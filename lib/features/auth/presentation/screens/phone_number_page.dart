import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/login_provider.dart';
import '../providers/otp_verify_provider.dart';

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
      if (previous?.isLoading == true &&
          next is AsyncData<UserEntity?> &&
          next.value != null) {
        ref.invalidate(otpVerifyProvider);
        context.go('/otp');
      }
    });

    final AsyncValue<UserEntity?> loginState = ref.watch(loginProvider);
    final UserEntity? user = loginState.value;
    final String? errorMessage = ref.read(loginProvider.notifier).errorMessage;
    final bool isLoading = loginState.isLoading;

    // Define brand colors matching the UI
    const Color bgColor = Color(0xFFFDF4F6); // Light pink background
    const Color primaryBlue = Color(0xFF67D1F2); // Cyan button
    const Color textColor = Color(0xFF1C1B1F); // Dark grey text
    const Color hintColor = Color(0xFF8E8E93); // Grey hint text
    const Color linkColor = Color(0xFFF88DAE); // Pink links

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: primaryBlue,
                  backgroundColor: linkColor,
                ),
              )
                  : Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryBlue, width: 4),
                  color: linkColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                // Header Text
                const Text(
                  'Enter your phone\nnumber',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Input Field Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 16.0),
                        child: Text(
                          '+95',
                          style: TextStyle(
                            fontSize: 18,
                            color: hintColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          enabled: !isLoading,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.telephoneNumber],
                          style: const TextStyle(
                            fontSize: 18,
                            color: textColor,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            hintText: '09254135592',
                            hintStyle: TextStyle(color: hintColor),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter your phone number.'
                              : null,
                          onFieldSubmitted: (_) => _submit(),
                        ),
                      ),
                      const SizedBox(width: 20), // Right padding for input
                    ],
                  ),
                ),

                // Error Message / User Card Display
                if (!isLoading && errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ] else if (!isLoading && user != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Phone: ${user.phone}', style: const TextStyle(color: hintColor)),
                        Text('Membership: ${user.member.name}', style: const TextStyle(color: hintColor)),
                        Text('Points: ${user.currentPoints}', style: const TextStyle(color: hintColor)),
                      ],
                    ),
                  ),
                ],

                const Spacer(),

                // Continue Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: isLoading ? null : _submit,
                    child: Text(
                      isLoading ? 'CHECKING…' : 'CONTINUE',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Footer Text
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      color: hintColor,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(
                        text: 'By continuing, you acknowledge that you have read and agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms of Use',
                        style: const TextStyle(
                          color: linkColor,
                          fontWeight: FontWeight.w500,
                        ),
                        // Add recognizer here if you need it clickable
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: const TextStyle(
                          color: linkColor,
                          fontWeight: FontWeight.w500,
                        ),
                        // Add recognizer here if you need it clickable
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}