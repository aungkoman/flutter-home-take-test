import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/login_provider.dart';
import '../providers/register_provider.dart';
import '../../domain/validators/auth_validators.dart';

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

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController(); // Keeps the formatted date for the API

  DateTime? _dob;
  String? _dobError; // inline error driven by AuthValidators.dob
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
        _dobError = null;
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
      _dobError = AuthValidators.dob(selected); // validate immediately on pick
      _dobController.text =
      '${selected.year.toString().padLeft(4, '0')}-'
          '${selected.month.toString().padLeft(2, '0')}-'
          '${selected.day.toString().padLeft(2, '0')}';
    });
  }

  Future<void> _submit() async {
    final String? dobValidationError = AuthValidators.dob(_dob);
    if (dobValidationError != null) {
      setState(() => _dobError = dobValidationError);
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

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    String hintText,
  ) {
    return TextFormField(
      controller: controller,
      enabled: !ref.read(registerProvider).isLoading,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: BorderSide(
            color: context.colorScheme.secondary,
            width: 1.5,
          ),
        ),
      ),
      validator: (String? value) => hintText == 'First Name'
          ? AuthValidators.firstName(value)
          : AuthValidators.lastName(value),
    );
  }

  Widget _buildDobDisplayBox(BuildContext context, String text) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Text(
        text,
        style: context.textTheme.bodyLarge?.copyWith(
          color: _dob == null ? appColors.textMuted : colorScheme.onSurface,
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

    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final UserEntity? user = ref.watch(loginProvider).value;
    final AsyncValue<UserEntity?> registration = ref.watch(registerProvider);
    final bool isLoading = registration.isLoading;
    final String? errorMessage = ref.read(registerProvider.notifier).errorMessage;

    return Scaffold(
      backgroundColor: appColors.blushBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: isLoading ? null : _previousStep,
                    ),
                  ),
                  CircularProgressIndicator(
                    value: _currentStep == 0 ? 0.5 : 1.0,
                    backgroundColor: colorScheme.surface,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Dynamic Title
              Text(
                _currentStep == 0
                    ? "What's your\nname?"
                    : "What's your\ndate of birth?",
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Dynamic Form Content
              Expanded(
                child: _currentStep == 0
                    // STEP 1: NAME FORM
                    ? Form(
                        key: _nameFormKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              context,
                              _firstNameController,
                              'First Name',
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            _buildTextField(
                              context,
                              _lastNameController,
                              'Last Name',
                            ),
                          ],
                        ),
                      )
                    // STEP 2: DOB FORM
                    : GestureDetector(
                        onTap: isLoading ? null : _pickDob,
                        child: Column(
                          children: [
                            _buildDobDisplayBox(
                              context,
                              _dob != null
                                  ? _months[_dob!.month - 1]
                                  : 'Month',
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            _buildDobDisplayBox(
                              context,
                              _dob != null ? _dob!.day.toString() : 'Day',
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            _buildDobDisplayBox(
                              context,
                              _dob != null ? _dob!.year.toString() : 'Year',
                            ),
                          ],
                        ),
                      ),
              ),

              // Error and User status messages
              if (_dobError != null && _currentStep == 1)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Text(
                    _dobError!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                ),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Text(
                    errorMessage,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                ),
              if (user == null)
                const Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.md),
                  child: Text('Enter your phone number before registering.'),
                ),

              // Continue / Submit Button — disabled when DOB is invalid on step 2
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading || user == null ||
                          (_currentStep == 1 &&
                              AuthValidators.dob(_dob) != null)
                      ? null
                      : (_currentStep == 0 ? _nextStep : _submit),
                  child: Text(
                    isLoading ? 'REGISTERING...' : 'CONTINUE',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Disclaimer Text
              Center(
                child: Text(
                  'By continuing, you acknowledge that you have read and\nagree to our Terms of Use and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: textTheme.labelSmall?.copyWith(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}