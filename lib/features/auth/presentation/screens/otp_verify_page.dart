
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/login_provider.dart';
import '../providers/otp_verify_provider.dart';

class OtpVerifyPage extends ConsumerStatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  ConsumerState<OtpVerifyPage> createState() =>
      _OtpVerifyPageState();
}

class _OtpVerifyPageState
    extends ConsumerState<OtpVerifyPage> {
  static const int _otpLength = 6;

  static const Color _primaryPink = Color(0xFFF653A6);
  static const Color _darkText = Color(0xFF262B30);
  static const Color _secondaryText = Color(0xFF50545D);

  final List<String> _digits =
  List<String>.filled(_otpLength, '');

  final List<FocusNode> _focusNodes =
  List<FocusNode>.generate(
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

  // Existing OTP input logic - unchanged
  void _onDigitChanged(int index, String digit) {
    setState(() => _digits[index] = digit);

    if (digit.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (digit.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  // Existing verification logic - unchanged
  Future<void> _verify() async {
    final UserEntity? loginUser =
        ref.read(loginProvider).value;

    if (loginUser == null) {
      context.go('/login');
      return;
    }

    final String code = _digits.join();

    if (code.length != _otpLength) return;

    await ref
        .read(otpVerifyProvider.notifier)
        .verifyOtp(
      userId: loginUser.id,
      otpCode: code,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Existing Riverpod navigation logic
    ref.listen<AsyncValue<UserEntity?>>(
      otpVerifyProvider,
          (previous, next) {
        if (previous?.isLoading != true ||
            next is! AsyncData<UserEntity?>) {
          return;
        }

        final UserEntity? user = next.value;

        if (user == null) return;

        context.go(
          user.firstName.trim().isEmpty
              ? '/register'
              : '/welcome',
        );
      },
    );

    final AsyncValue<UserEntity?> otpState =
    ref.watch(otpVerifyProvider);

    final UserEntity? loginUser =
        ref.watch(loginProvider).value;

    final bool isLoading = otpState.isLoading;

    final String? errorMessage = ref
        .read(otpVerifyProvider.notifier)
        .errorMessage;

    final String code = _digits.join();

    // Detect keyboard visibility
    final bool isKeyboardOpen =
        MediaQuery.viewInsetsOf(context).bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFF8FB),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFCECF2),
              Color(0xFFFFFAFC),
              Color(0xFFFFF5F8),
            ],
            stops: [0.0, 0.57, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Column(
                children: [
                  // MAIN CONTENT
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior
                          .onDrag,
                      padding: const EdgeInsets.fromLTRB(
                        32,
                        28,
                        32,
                        24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          // HEADER
                          _buildHeader(context),

                          const SizedBox(height: 36),

                          // TITLE
                          const Text(
                            'Verify your number',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              letterSpacing: -0.7,
                              color: _darkText,
                            ),
                          ),

                          const SizedBox(height: 14),

                          // DESCRIPTION
                          const Text(
                            "We've sent 6 digit OTP to your phone number",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: _secondaryText,
                            ),
                          ),

                          const SizedBox(height: 36),

                          // OTP INPUT
                          _buildOtpFields(isLoading),

                          const SizedBox(height: 24),

                          // RESEND SECTION
                          _buildResendSection(),

                          // ERROR MESSAGE
                          if (errorMessage != null) ...[
                            const SizedBox(height: 20),
                            Text(
                              errorMessage,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .colorScheme
                                    .error,
                              ),
                            ),
                          ],

                          // LOGIN REQUIRED
                          if (loginUser == null) ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Enter your phone number first.',
                              style: TextStyle(
                                color: _secondaryText,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.go('/login'),
                              child: const Text(
                                'Go to Login',
                              ),
                            ),
                          ],

                          const SizedBox(height: 28),

                          // VERIFY BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: FilledButton(
                              onPressed:
                              code.length == _otpLength &&
                                  !isLoading &&
                                  loginUser != null
                                  ? _verify
                                  : null,
                              style: FilledButton.styleFrom(
                                backgroundColor: _primaryPink,
                                disabledBackgroundColor:
                                const Color(0xFFF8B7D8),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                isLoading
                                    ? 'Verifying…'
                                    : 'Verify',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // FOOTER:
                  // Hide when keyboard is open
                  if (!isKeyboardOpen)
                    _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------
  // HEADER
  // -------------------------

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/login');
              }
            },
            child: const SizedBox(
              width: 42,
              height: 42,
              child: Icon(
                Icons.arrow_back,
                color: _darkText,
                size: 24,
              ),
            ),
          ),
        ),

        // Decorative brand symbol
        SizedBox(
          width: 34,
          height: 34,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      Color(0xFF91DDF6),
                      _primaryPink,
                      _primaryPink,
                      Color(0xFF91DDF6),
                    ],
                  ),
                ),
              ),
              Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF6F9),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------
  // OTP INPUT FIELDS
  // -------------------------

  Widget _buildOtpFields(bool isLoading) {
    return Row(
      children: List<Widget>.generate(
        _otpLength,
            (int index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index == _otpLength - 1
                    ? 0
                    : 9,
              ),
              child: Semantics(
                label:
                'Digit ${index + 1} of $_otpLength',
                child: SizedBox(
                  height: 58,
                  child: TextField(
                    focusNode: _focusNodes[index],
                    enabled: !isLoading,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textAlignVertical:
                    TextAlignVertical.center,
                    selectAllOnFocus: true,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: _darkText,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: _primaryPink,
                          width: 1.5,
                        ),
                      ),
                    ),
                    onChanged: (String digit) {
                      _onDigitChanged(index, digit);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // -------------------------
  // RESEND OTP - UI ONLY
  // -------------------------

  Widget _buildResendSection() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          "Didn't receive the code?",
          style: TextStyle(
            fontSize: 14,
            color: _secondaryText,
            height: 1.5,
          ),
        ),
        SizedBox(height: 2),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'resend in ',
                style: TextStyle(
                  color: _secondaryText,
                ),
              ),
              TextSpan(
                text: '4:58',
                style: TextStyle(
                  color: _primaryPink,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' min',
                style: TextStyle(
                  color: _secondaryText,
                ),
              ),
            ],
          ),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // -------------------------
  // FOOTER
  // -------------------------

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        32,
        12,
        32,
        24,
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text:
              'By continuing, you acknowledge that '
                  'you have read and agree to our ',
            ),
            TextSpan(
              text: 'Terms of Use',
              style: TextStyle(
                color: _primaryPink,
              ),
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy.',
              style: TextStyle(
                color: _primaryPink,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          height: 1.55,
          color: Color(0xFF9DA2B0),
        ),
      ),
    );
  }
}
