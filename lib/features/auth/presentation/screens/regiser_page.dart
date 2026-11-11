import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/login_provider.dart';
import '../providers/register_provider.dart';

const List<String> _months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dobFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController(); // Keeps the formatted date for the API

  DateTime? _dob;
  int _currentStep = 0; // 0 for Name, 1 for DOB

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (_nameFormKey.currentState?.validate() == true) {
        setState(() {
          _currentStep = 1;
        });
      }
    }
  }

  void _previousStep() {
    if (_currentStep == 1) {
      setState(() {
        _currentStep = 0;
      });
    } else {
      context.pop(); // Go back to previous route if on first step
    }
  }

  Future<void> _pickDob() async {
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: today,
    );
    if (!mounted || selected == null) return;

    setState(() {
      _dob = selected;
      _dobController.text =
      '${selected.year.toString().padLeft(4, '0')}-'
          '${selected.month.toString().padLeft(2, '0')}-'
          '${selected.day.toString().padLeft(2, '0')}';
    });
  }

  Future<void> _submit() async {
    if (_dob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your date of birth')),
      );
      return;
    }

    final UserEntity? user = ref.read(loginProvider).value;
    if (user == null) return;

    await ref
        .read(registerProvider.notifier)
        .register(
      userId: user.id,
      phone: user.phone,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      dob: _dobController.text,
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        enabled: !ref.read(registerProvider).isLoading,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        validator: (String? value) =>
        value == null || value.trim().isEmpty ? 'Enter your ${hintText.toLowerCase()}' : null,
      ),
    );
  }

  Widget _buildDobDisplayBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: _dob == null ? Colors.black38 : Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<UserEntity?>>(registerProvider, (previous, next) {
      if (previous?.isLoading == true &&
          next is AsyncData<UserEntity?> &&
          next.value != null) {
        context.go('/welcome');
      }
    });

    final UserEntity? user = ref.watch(loginProvider).value;
    final AsyncValue<UserEntity?> registration = ref.watch(registerProvider);
    final bool isLoading = registration.isLoading;
    final String? errorMessage = ref.read(registerProvider.notifier).errorMessage;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF0F5), // Light pink background matching reference
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: isLoading ? null : _previousStep,
                    ),
                  ),
                  CircularProgressIndicator(
                    value: _currentStep == 0 ? 0.5 : 1.0,
                    backgroundColor: Colors.white,
                    color: Colors.pinkAccent,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Dynamic Title
              Text(
                _currentStep == 0 ? "What's your\nname?" : "What's your\ndate of birth?",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),

              // Dynamic Form Content
              Expanded(
                child: _currentStep == 0
                // STEP 1: NAME FORM
                    ? Form(
                  key: _nameFormKey,
                  child: Column(
                    children: [
                      _buildTextField(_firstNameController, 'First Name'),
                      const SizedBox(height: 16),
                      _buildTextField(_lastNameController, 'Last Name'),
                    ],
                  ),
                )
                // STEP 2: DOB FORM
                    : GestureDetector(
                  onTap: isLoading ? null : _pickDob,
                  child: Column(
                    children: [
                      _buildDobDisplayBox(_dob != null ? _months[_dob!.month - 1] : 'Month'),
                      const SizedBox(height: 16),
                      _buildDobDisplayBox(_dob != null ? _dob!.day.toString() : 'Day'),
                      const SizedBox(height: 16),
                      _buildDobDisplayBox(_dob != null ? _dob!.year.toString() : 'Year'),
                    ],
                  ),
                ),
              ),

              // Error and User status messages
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              if (user == null)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('Enter your phone number before registering.'),
                ),

              // Continue / Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading || user == null
                      ? null
                      : (_currentStep == 0 ? _nextStep : _submit),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4FC3F7), // Light blue matching reference
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isLoading ? 'REGISTERING...' : 'CONTINUE',
                    style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Disclaimer Text
              const Center(
                child: Text(
                  'By continuing, you acknowledge that you have read and\nagree to our Terms of Use and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Colors.black38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}