import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/login_provider.dart';
import '../providers/otp_verify_provider.dart';

class OtpVerifyPage extends ConsumerStatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  ConsumerState<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends ConsumerState<OtpVerifyPage> {
  static const int _otpLength = 6;

  final List<String> _digits = List<String>.filled(_otpLength, '');
  final List<FocusNode> _focusNodes = List<FocusNode>.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  @override
  void dispose() {
    for (final FocusNode focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String digit) {
    setState(() => _digits[index] = digit);

    if (digit.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (digit.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verify() async {
    // user id လိုချင်လို့
    final UserEntity? loginUser = ref.read(loginProvider).value;
    if (loginUser == null) {
      // ဖုန်းနံပါတ် ထည့်ပြီး user id ပြန်သွားယူ
      context.go('/login');
      return;
    }

    final String code = _digits.join();
    if (code.length != _otpLength) return;

    await ref
        .read(otpVerifyProvider.notifier)
        .verifyOtp(userId: loginUser.id, otpCode: code);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<UserEntity?>>(otpVerifyProvider, (previous, next) {
      if (previous?.isLoading != true || next is! AsyncData<UserEntity?>) {

        return;
      }

      final UserEntity? user = next.value;
      if (user == null) return;

      context.go(user.firstName.trim().isEmpty ? '/register' : '/home');
    });

    final AsyncValue<UserEntity?> otpState = ref.watch(otpVerifyProvider);
    final UserEntity? loginUser = ref.watch(loginProvider).value;
    final bool isLoading = otpState.isLoading;
    final String? errorMessage = ref
        .read(otpVerifyProvider.notifier)
        .errorMessage;
    final String code = _digits.join();

    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Enter the 6-digit verification code.'),
                  const SizedBox(height: 16),
                  Row(
                    children: List<Widget>.generate(_otpLength, (int index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Semantics(
                            label: 'Digit ${index + 1} of $_otpLength',
                            child: TextField(
                              focusNode: _focusNodes[index],
                              enabled: !isLoading,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              selectAllOnFocus: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onChanged: (String digit) =>
                                  _onDigitChanged(index, digit),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed:
                        code.length == _otpLength &&
                            !isLoading &&
                            loginUser != null
                        ? _verify
                        : null,
                    child: Text(isLoading ? 'Verifying…' : 'Verify'),
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
                  if (loginUser == null) ...[
                    const SizedBox(height: 12),
                    const Text('Enter your phone number first.'),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Go to Login'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
