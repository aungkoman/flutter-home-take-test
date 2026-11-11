import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/core/theme/app_theme.dart';
import 'package:hometake/features/auth/domain/usecases/user_login_use_case.dart';
import 'package:hometake/features/auth/domain/usecases/user_otp_verify.dart';
import 'package:hometake/features/auth/presentation/providers/login_provider.dart';
import 'package:hometake/features/auth/presentation/providers/otp_verify_provider.dart';
import 'package:hometake/features/auth/presentation/screens/otp_verify_page.dart';

class _UnusedLogin extends Fake implements UserLoginUseCase {}

class _UnusedOtp extends Fake implements UserOtpVerify {}

class _Login extends LoginNotifier {
  _Login() : super(_UnusedLogin());
  @override
  UserEntity? build() => UserEntity.sample;
}

class _Otp extends OtpVerifyNotifier {
  _Otp() : super(_UnusedOtp());
  @override
  Future<void> verifyOtp({required int userId, required String otpCode}) async {
    state = const AsyncLoading();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    state = AsyncError(StateError('Invalid code'), StackTrace.current);
  }
}

void main() {
  testWidgets('failed OTP clears digits, shakes, and focuses first input', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          loginProvider.overrideWith(_Login.new),
          otpVerifyProvider.overrideWith(_Otp.new),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const OtpVerifyPage()),
      ),
    );
    final fields = find.byType(TextField);
    for (var i = 0; i < 6; i++) {
      await tester.enterText(fields.at(i), '9');
    }
    await tester.pump();
    await tester.ensureVisible(find.text('Verify'));
    await tester.tap(find.text('Verify'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump(const Duration(milliseconds: 35));
    for (final field in tester.widgetList<TextField>(fields)) {
      expect(field.controller!.text, isEmpty);
    }
    expect(tester.widget<TextField>(fields.first).focusNode!.hasFocus, isTrue);
    final transform = tester.widget<Transform>(
      find.byKey(const ValueKey('otp-shake')),
    );
    expect(transform.transform.storage[12].abs(), greaterThan(0));
    await tester.pump(const Duration(milliseconds: 500));
    expect(
      tester
          .widget<Transform>(find.byKey(const ValueKey('otp-shake')))
          .transform
          .storage[12]
          .abs(),
      lessThan(.001),
    );
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
