import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/features/auth/domain/validators/auth_validators.dart';

void main() {
  group('Phone validation boundary regression', () {
    test('canonical forms remain equivalent', () {
      const variants = [
        '09254135592',
        '+959254135592',
        '09 254-135592',
      ];
      for (final phone in variants) {
        expect(canonicalizePhone(phone), '+959254135592',
            reason: 'Canonicalization differs for $phone');
      }
    });

    test('malformed phone never yields a canonical identifier', () {
      for (final phone in ['', '123', '09abc135592']) {
        expect(canonicalizePhone(phone), isNull,
            reason: 'Invalid phone accepted: $phone');
      }
    });

    test('OTP rejects nonnumeric and incorrect length', () {
      for (final otp in ['', '12345', '1234567', '12345a']) {
        expect(AuthValidators.otp(otp), isNotNull);
      }
      expect(AuthValidators.otp('123456'), isNull);
    });
  });
}
