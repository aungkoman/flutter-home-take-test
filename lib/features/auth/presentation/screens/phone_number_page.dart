import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hometake/features/auth/presentation/screens/otp_verify_page.dart';

import '../providers/login_provider.dart';

class PhoneNumberPage extends ConsumerStatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  ConsumerState<PhoneNumberPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<PhoneNumberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) {
      log('PhoneNumberPage._submit: form validation failed; no login call',
          name: 'auth.login');
      return;
    }
    log(
      'PhoneNumberPage._submit -> LoginNotifier.login '
      '| input String phone=${_phoneController.text}',
      name: 'auth.login',
    );
    await ref.read(loginProvider.notifier).login(_phoneController.text);
    log('PhoneNumberPage._submit <- Future<void> completed', name: 'auth.login');
  }

  @override
  Widget build(BuildContext context) {

    // Listen to the provider for side-effects (Navigation)
    // why it has data even the usecase return failure
    ref.listen<AsyncValue<UserEntity?>>(loginProvider, (previous, next) {
      final UserEntity? returnedUser = next.value;
      log(
        'PhoneNumberPage.ref.listen <- AsyncValue<UserEntity?> '
        '| runtime=${next.runtimeType}, loading=${next.isLoading}, '
        'error=${next.error}, userId=${returnedUser?.id}, '
        'name=${returnedUser?.firstName} ${returnedUser?.lastName}, '
        'phone=${returnedUser?.phone}, points=${returnedUser?.currentPoints}, '
        'tier=${returnedUser?.member.name}',
        name: 'auth.login',
      );
      // Check if we just finished loading and successfully got a user
      if (previous?.isLoading == true && !next.isLoading && next.value != null) {
        context.go('/otp');
      }
    });

    final AsyncValue<UserEntity?> loginState = ref.watch(loginProvider);
    final UserEntity? user = loginState.value;
    final String? errorMessage = ref.read(loginProvider.notifier).errorMessage;
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
                    if (!isLoading && errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        errorMessage,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ] else if (!isLoading && user != null) ...[
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text('Phone: ${user.phone}'),
                              Text('Membership: ${user.member.name}'),
                              Text('Points: ${user.currentPoints}'),
                            ],
                          ),
                        ),
                      ),
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
