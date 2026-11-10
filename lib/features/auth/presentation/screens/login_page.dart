import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/user_login.dart';
import '../providers/login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key, required this.userLogin});

  final UserLogin userLogin;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;

    await ref
        .read(loginProvider(widget.userLogin).notifier)
        .login(_phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserEntity?> loginState = ref.watch(
      loginProvider(widget.userLogin),
    );
    final Object? error = loginState.error;
    final bool isLoading = loginState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Log in')),
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
                    TextFormField(
                      controller: _phoneController,
                      enabled: !isLoading,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                        hintText: '+95',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter your phone number.'
                          : null,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: isLoading ? null : _submit,
                      child: Text(isLoading ? 'Checking…' : 'Continue'),
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        error is SingleMessageReturnFailure
                            ? error.message
                            : 'Could not check your phone number. Try again.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ] else if (loginState.value != null) ...[
                      const SizedBox(height: 12),
                      const Text('Phone number found.'),
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
