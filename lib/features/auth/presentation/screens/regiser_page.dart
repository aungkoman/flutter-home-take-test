import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/login_provider.dart';
import '../providers/register_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _dob;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _dob ?? today,
      firstDate: DateTime(1900),
      lastDate: today,
    );
    if (!mounted || selected == null) return;

    _dob = selected;
    _dobController.text =
        '${selected.year.toString().padLeft(4, '0')}-'
        '${selected.month.toString().padLeft(2, '0')}-'
        '${selected.day.toString().padLeft(2, '0')}';
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
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
    final String? errorMessage = ref
        .read(registerProvider.notifier)
        .errorMessage;

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (user != null) ...[
                      Text('Phone: ${user.phone}'),
                      const SizedBox(height: 16),
                    ],
                    TextFormField(
                      controller: _firstNameController,
                      enabled: !isLoading,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'First name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter your first name.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameController,
                      enabled: !isLoading,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Last name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter your last name.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dobController,
                      enabled: !isLoading,
                      readOnly: true,
                      onTap: _pickDob,
                      decoration: const InputDecoration(
                        labelText: 'Date of birth',
                        hintText: 'YYYY-MM-DD',
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) =>
                          value == null || value.isEmpty
                          ? 'Select your date of birth.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: !isLoading && user != null ? _submit : null,
                      child: Text(isLoading ? 'Registering…' : 'Register'),
                    ),
                    if (errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        errorMessage,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                    if (user == null) ...[
                      const SizedBox(height: 12),
                      const Text('Enter your phone number before registering.'),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
