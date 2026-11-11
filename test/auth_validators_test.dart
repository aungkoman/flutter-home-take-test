import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/features/auth/domain/validators/auth_validators.dart';

void main() {
  // ---------------------------------------------------------------------------
  // AuthValidators.phone
  // ---------------------------------------------------------------------------
  group('AuthValidators.phone', () {
    test('null → error', () {
      expect(AuthValidators.phone(null), isNotNull);
    });

    test('empty string → error', () {
      expect(AuthValidators.phone(''), isNotNull);
    });

    test('09254135592 (local with leading 0) → valid', () {
      expect(AuthValidators.phone('09254135592'), isNull);
    });

    test('+959254135592 (with country code) → valid', () {
      expect(AuthValidators.phone('+959254135592'), isNull);
    });

    test('9254135592 (already normalised) → valid', () {
      expect(AuthValidators.phone('9254135592'), isNull);
    });

    test('too short after normalise → error', () {
      // 9 + 6 digits = 7 total, minimum is 8
      expect(AuthValidators.phone('09123456'), isNotNull);
    });

    test('too long after normalise → error', () {
      // 9 + 10 digits = 11 total, maximum is 10
      expect(AuthValidators.phone('092541355920'), isNotNull);
    });

    test('letters in number → error', () {
      expect(AuthValidators.phone('0ABCDEFGH'), isNotNull);
    });
  });

  // ---------------------------------------------------------------------------
  // AuthValidators.firstName
  // ---------------------------------------------------------------------------
  group('AuthValidators.firstName', () {
    test('null → required error', () {
      expect(AuthValidators.firstName(null), isNotNull);
    });

    test('empty string → required error', () {
      expect(AuthValidators.firstName(''), isNotNull);
    });

    test('whitespace only → required error', () {
      expect(AuthValidators.firstName('   '), isNotNull);
    });

    test('valid Latin name → null', () {
      expect(AuthValidators.firstName('Alice'), isNull);
    });

    test('valid Myanmar-script name → null', () {
      // Myanmar characters in U+1000-U+109F range
      expect(AuthValidators.firstName('\u1000\u1031\u102c'), isNull);
    });

    test('digits in name → error', () {
      expect(AuthValidators.firstName('Alice1'), isNotNull);
    });

    test('exactly 50 chars → valid', () {
      expect(AuthValidators.firstName('A' * 50), isNull);
    });

    test('51 chars → error', () {
      expect(AuthValidators.firstName('A' * 51), isNotNull);
    });
  });

  // ---------------------------------------------------------------------------
  // AuthValidators.lastName
  // ---------------------------------------------------------------------------
  group('AuthValidators.lastName', () {
    test('null → null (optional field)', () {
      expect(AuthValidators.lastName(null), isNull);
    });

    test('empty string → null (optional field)', () {
      expect(AuthValidators.lastName(''), isNull);
    });

    test('whitespace only → null (optional field)', () {
      expect(AuthValidators.lastName('   '), isNull);
    });

    test('valid name → null', () {
      expect(AuthValidators.lastName('Smith'), isNull);
    });

    test('digits in name → error', () {
      expect(AuthValidators.lastName('Smith2'), isNotNull);
    });

    test('over 50 chars → error', () {
      expect(AuthValidators.lastName('B' * 51), isNotNull);
    });
  });

  // ---------------------------------------------------------------------------
  // AuthValidators.dob
  // ---------------------------------------------------------------------------
  group('AuthValidators.dob', () {
    test('null → required error', () {
      expect(AuthValidators.dob(null), isNotNull);
    });

    test('future date → error', () {
      final future = DateTime.now().add(const Duration(days: 1));
      expect(AuthValidators.dob(future), isNotNull);
    });

    test('today → under 13 (age = 0) → error', () {
      expect(AuthValidators.dob(DateTime.now()), isNotNull);
    });

    test('exactly $kMinAgeYears years old today → valid', () {
      final today = DateTime.now();
      final exactlyOldEnough =
          DateTime(today.year - kMinAgeYears, today.month, today.day);
      expect(AuthValidators.dob(exactlyOldEnough), isNull);
    });

    test('one day short of $kMinAgeYears years → error', () {
      final today = DateTime.now();
      final oneDayShort = DateTime(
        today.year - kMinAgeYears,
        today.month,
        today.day,
      ).add(const Duration(days: 1));
      expect(AuthValidators.dob(oneDayShort), isNotNull);
    });

    test('30 years old → valid', () {
      final today = DateTime.now();
      final thirtyYearsAgo = DateTime(today.year - 30, today.month, today.day);
      expect(AuthValidators.dob(thirtyYearsAgo), isNull);
    });

    test('year 1900 → valid (age > 13)', () {
      expect(AuthValidators.dob(DateTime(1900, 1, 1)), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // AuthValidators.otp
  // ---------------------------------------------------------------------------
  group('AuthValidators.otp', () {
    test('null → error', () {
      expect(AuthValidators.otp(null), isNotNull);
    });

    test('empty string → error', () {
      expect(AuthValidators.otp(''), isNotNull);
    });

    test('5 digits → error', () {
      expect(AuthValidators.otp('12345'), isNotNull);
    });

    test('7 digits → error', () {
      expect(AuthValidators.otp('1234567'), isNotNull);
    });

    test('6 digits → valid', () {
      expect(AuthValidators.otp('123456'), isNull);
    });

    test('6 chars with letter → error', () {
      expect(AuthValidators.otp('12345a'), isNotNull);
    });
  });
}
