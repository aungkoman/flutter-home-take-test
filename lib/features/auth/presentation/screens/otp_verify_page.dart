import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/login_provider.dart';
import '../providers/otp_verify_provider.dart';

/// Duration of the OTP resend countdown (spec: 5 minutes).
const Duration _kResendCountdown = Duration(minutes: 5);

class OtpVerifyPage extends ConsumerStatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  ConsumerState<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends ConsumerState<OtpVerifyPage> {
  static const int _otpLength = 6;

  final List<String> _digits = List<String>.filled(_otpLength, '');

  // One controller per box so we can clear a box programmatically when
  // the user backspaces into it from the following box.
  final List<TextEditingController> _controllers =
      List<TextEditingController>.generate(
        _otpLength,
        (_) => TextEditingController(),
      );

  final List<FocusNode> _focusNodes = List<FocusNode>.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  // ── Countdown state ───────────────────────────────────────────────────────
  late int _secondsLeft;
  Timer? _countdownTimer;

  /// Whether the Resend button is active (countdown has reached zero).
  bool get _canResend => _secondsLeft == 0;

  /// MM:SS label shown in the resend section.
  String get _countdownLabel {
    final int m = _secondsLeft ~/ 60;
    final int s = _secondsLeft % 60;
    return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _attachBackspaceHandlers();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (int i = 0; i < _otpLength; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  // ── Backspace handler ─────────────────────────────────────────────────────

  /// Hooks into each [FocusNode] so a backspace key-down on an **empty** box
  /// clears the previous box and shifts focus back to it.
  ///
  /// Why not use [onChanged]? [onChanged] only fires when the field *value
  /// changes*. If a box is already empty the value cannot change, so backspace
  /// is silently swallowed — this key-event handler catches it.
  void _attachBackspaceHandlers() {
    for (int i = 0; i < _otpLength; i++) {
      final int index = i;
      _focusNodes[index].onKeyEvent = (_, KeyEvent event) {
        final bool isBackspace =
            event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace;

        if (isBackspace && _digits[index].isEmpty && index > 0) {
          setState(() {
            _digits[index - 1] = '';
            _controllers[index - 1].clear();
          });
          _focusNodes[index - 1].requestFocus();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
    }
  }

  // ── Countdown helpers ─────────────────────────────────────────────────────

  /// Starts (or restarts) the 5-minute countdown.
  void _startCountdown() {
    _countdownTimer?.cancel();
    _secondsLeft = _kResendCountdown.inSeconds;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsLeft == 0) {
        timer.cancel();
        setState(() {}); // refresh so Resend button becomes active
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  // ── OTP input helpers ─────────────────────────────────────────────────────

  void _onDigitChanged(int index, String digit) {
    final bool wasFilled = _digits[index].isNotEmpty;
    setState(() => _digits[index] = digit);

    // Advance to the next box when a digit is entered.
    if (digit.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (digit.isEmpty && wasFilled && index > 0) {
      _focusNodes[index - 1].requestFocus();
      final TextEditingController previous = _controllers[index - 1];
      previous.selection = TextSelection(
        baseOffset: 0,
        extentOffset: previous.text.length,
      );
    }
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  Future<void> _verify() async {
    final UserEntity? loginUser = ref.read(loginProvider).value;

    if (loginUser == null) {
      context.go('/login');
      return;
    }

    final String code = _digits.join();
    if (code.length != _otpLength) return;

    await ref
        .read(otpVerifyProvider.notifier)
        .verifyOtp(userId: loginUser.id, otpCode: code);
  }

  /// Called when the user taps Resend. Restarts the countdown.
  void _resend() {
    if (!_canResend) return;
    _startCountdown();
    // TODO: trigger real resend call via provider when backend supports it.
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Navigation side-effects
    ref.listen<AsyncValue<UserEntity?>>(otpVerifyProvider, (previous, next) {
      if (previous?.isLoading != true || next is! AsyncData<UserEntity?>) {
        return;
      }
      final UserEntity? user = next.value;
      if (user == null) return;
      context.go(user.firstName.trim().isEmpty ? '/register' : '/welcome');
    });

    final AsyncValue<UserEntity?> otpState = ref.watch(otpVerifyProvider);
    final UserEntity? loginUser = ref.watch(loginProvider).value;
    final bool isLoading = otpState.isLoading;
    final String? errorMessage = ref
        .read(otpVerifyProvider.notifier)
        .errorMessage;
    final String code = _digits.join();

    final bool isKeyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appColors.blushBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: appColors.blushGradient,
            stops: const [0.0, 0.57, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  // ── Main scrollable content ──────────────────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(32, 28, 32, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HEADER
                          _buildHeader(context),

                          const SizedBox(height: 36),

                          // TITLE
                          Text(
                            'Verify your number',
                            style: textTheme.displaySmall?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                            ),
                          ),

                          const SizedBox(height: 14),

                          // DESCRIPTION
                          Text(
                            "We've sent 6 digit OTP to your phone number",
                            style: textTheme.bodyMedium?.copyWith(height: 1.5),
                          ),

                          const SizedBox(height: 36),

                          // OTP INPUT BOXES
                          _buildOtpFields(context, isLoading),

                          const SizedBox(height: AppSpacing.xl),

                          // RESEND SECTION
                          _buildResendSection(context),

                          // ERROR MESSAGE
                          if (errorMessage != null) ...[
                            const SizedBox(height: 20),
                            Text(
                              errorMessage,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.error,
                              ),
                            ),
                          ],

                          // LOGIN REQUIRED GUARD
                          if (loginUser == null) ...[
                            const SizedBox(height: AppSpacing.lg),
                            Text(
                              'Enter your phone number first.',
                              style: textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () => context.go('/login'),
                              child: const Text('Go to Login'),
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
                                backgroundColor: colorScheme.secondary,
                                disabledBackgroundColor: appColors.pinkDisabled,
                                foregroundColor: colorScheme.onSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.md,
                                  ),
                                ),
                              ),
                              child: Text(
                                isLoading ? 'Verifying…' : 'Verify',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
                  ),

                  // ── Footer — hidden when keyboard is open ────────────────
                  if (!isKeyboardOpen) _buildFooter(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Sub-builders ──────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: colorScheme.surface,
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
              child: Icon(Icons.arrow_back, size: 24),
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      appColors.cyanLight,
                      colorScheme.secondary,
                      colorScheme.secondary,
                      appColors.cyanLight,
                    ],
                  ),
                ),
              ),
              Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  color: appColors.blushBackground,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpFields(BuildContext context, bool isLoading) {
    final ColorScheme colorScheme = context.colorScheme;
    final TextTheme textTheme = context.textTheme;
    return Row(
      children: List<Widget>.generate(_otpLength, (int index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == _otpLength - 1 ? 0 : 9),
            child: Semantics(
              label: 'Digit ${index + 1} of $_otpLength',
              child: SizedBox(
                height: 58,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  enabled: !isLoading,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  selectAllOnFocus: true,
                  style: textTheme.headlineMedium?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: colorScheme.secondary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (String digit) => _onDigitChanged(index, digit),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Resend section with live countdown.
  ///
  /// Spec: countdown from 5:00; Resend becomes active at 0:00 and restarts
  /// the timer when tapped.
  Widget _buildResendSection(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final TextTheme textTheme = context.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Didn't receive the code?",
          style: textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 2),
        _canResend
            // ── Resend active ───────────────────────────────────────────────
            ? GestureDetector(
                onTap: _resend,
                child: Text(
                  'Resend code',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            // ── Countdown ticking ───────────────────────────────────────────
            : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'resend in ',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                    TextSpan(
                      text: _countdownLabel,
                      style: TextStyle(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' min',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                style: textTheme.bodyMedium,
              ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final TextTheme textTheme = context.textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text:
                  'By continuing, you acknowledge that '
                  'you have read and agree to our ',
            ),
            TextSpan(
              text: 'Terms of Use',
              style: TextStyle(color: colorScheme.secondary),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy.',
              style: TextStyle(color: colorScheme.secondary),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: textTheme.labelSmall?.copyWith(fontSize: 12, height: 1.55),
      ),
    );
  }
}
