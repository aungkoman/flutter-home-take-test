/// Pure-Dart auth validators living in the **domain layer**.
///
/// Every public function follows the Flutter [FormFieldValidator] contract so
/// they can be passed directly to [TextFormField.validator] from the
/// presentation layer without any adapter:
///   - Returns `null`           → value is **valid**.
///   - Returns a non-null string → value is **invalid**; string shown inline.
///
/// No Flutter / package imports — only `dart:core` — so these functions are
/// testable without a Flutter environment and reusable in UseCases.
library;

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/// Minimum age a user must be to register.
const int kMinAgeYears = 13;

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

/// Myanmar mobile number pattern (after country-code / leading-zero removal):
///   9  followed by 7–9 digits → total 8–10 digits including the leading 9.
const _myanmarPhoneRe = r'^9[0-9]{7,9}$';

/// Allowed characters in a name field: Latin letters, Myanmar Unicode block
/// (U+1000–U+109F), and spaces. No digits or punctuation.
const _nameCharRe = r'^[\u1000-\u109Fa-zA-Z ]+$';

/// Strips spaces and dashes, removes +95 / bare 95 country prefix, then
/// strips a single leading 0 to produce the canonical local form.
///
/// Returns `null` when the input collapses to an empty string.
///
/// Examples:
///   "09254135592"   → "9254135592"
///   "+959254135592" → "9254135592"
///   "959254135592"  → "9254135592"
///   "9254135592"    → "9254135592"
String? _normalisePhone(String raw) {
  String d = raw.replaceAll(RegExp(r'[\s\-]'), '');
  if (d.startsWith('+95')) {
    d = d.substring(3);
  } else if (d.startsWith('959') && d.length > 10) {
    d = d.substring(2); // bare country code (no +)
  }
  if (d.startsWith('0')) d = d.substring(1);
  return d.isEmpty ? null : d;
}

/// Returns a validated +95 phone, or null when the input is invalid.
/// Keep this canonical form at the use-case and persistence boundaries.
String? canonicalizePhone(String? raw) {
  if (raw == null) return null;
  final String? local = _normalisePhone(raw.trim());
  if (local == null || !RegExp(_myanmarPhoneRe).hasMatch(local)) return null;
  return '+95$local';
}

// ---------------------------------------------------------------------------
// Phone
// ---------------------------------------------------------------------------

/// Validates a Myanmar phone number typed after the fixed "+95 |" prefix.
///
/// Accepts: 09254135592, +959254135592, 9254135592.
/// Rejects: too-short, too-long, letters, empty.
String? validatePhone(String? raw) {
  if (raw == null || raw.trim().isEmpty) {
    return 'Enter your phone number.';
  }
  if (canonicalizePhone(raw) == null) {
    return 'Enter a valid Myanmar phone number (e.g. 09254135592).';
  }
  return null;
}

// ---------------------------------------------------------------------------
// Name
// ---------------------------------------------------------------------------

/// Validates the **required** first-name field.
///
/// Rules: 1–50 chars after trimming; Latin or Myanmar-script letters and
/// spaces only; no digits.
String? validateFirstName(String? raw) {
  final String v = raw?.trim() ?? '';
  if (v.isEmpty) return 'First name is required.';
  if (v.length > 50) return 'First name must be 50 characters or fewer.';
  if (!RegExp(_nameCharRe).hasMatch(v)) {
    return 'First name may only contain letters and spaces.';
  }
  return null;
}

/// Validates the **optional** last-name field.
///
/// Returns `null` (passes) when empty — many Myanmar names have no family
/// name. When non-empty the same character rules as [validateFirstName] apply.
String? validateLastName(String? raw) {
  final String v = raw?.trim() ?? '';
  if (v.isEmpty) return null; // optional
  if (v.length > 50) return 'Last name must be 50 characters or fewer.';
  if (!RegExp(_nameCharRe).hasMatch(v)) {
    return 'Last name may only contain letters and spaces.';
  }
  return null;
}

// ---------------------------------------------------------------------------
// Date of birth
// ---------------------------------------------------------------------------

/// Parses YYYY-MM-DD without accepting Dart's calendar overflow normalization.
/// For example, 31 April and non-leap-year 29 February return null.
DateTime? parseDateOfBirth(String? raw) {
  final RegExpMatch? match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$')
      .firstMatch(raw?.trim() ?? '');
  if (match == null) return null;
  final int year = int.parse(match[1]!);
  final int month = int.parse(match[2]!);
  final int day = int.parse(match[3]!);
  if (year < 1) return null;
  final DateTime date = DateTime(year, month, day);
  return date.year == year && date.month == month && date.day == day
      ? date
      : null;
}

/// Shared validation for use-case callers and direct local persistence callers.
String? validateRegistrationData({
  required String firstName,
  required String lastName,
  required String dob,
}) {
  final String? nameError =
      validateFirstName(firstName) ?? validateLastName(lastName);
  if (nameError != null) return nameError;
  final DateTime? date = parseDateOfBirth(dob);
  if (date == null) return 'Date of birth is not valid.';
  return validateDob(date);
}

/// Validates the date-of-birth selection.
///
/// Rules (from spec):
///   - Must be a real calendar date (no 31 April; 29 Feb only in leap years).
///   - Must not be in the future.
///   - Age must be at least [kMinAgeYears] (= 13).
///
/// [selected] is the [DateTime] returned by [showDatePicker]; pass `null` to
/// trigger the "required" message.
String? validateDob(DateTime? selected) {
  if (selected == null) return 'Please select your date of birth.';

  final DateTime today = DateTime.now();
  final DateTime todayOnly = DateTime(today.year, today.month, today.day);

  // Future date guard (showDatePicker already constrains lastDate to today,
  // but we guard here too so the domain rule is self-contained).
  if (selected.isAfter(todayOnly)) {
    return 'Date of birth cannot be in the future.';
  }

  // Age check: birthday this calendar year might not have occurred yet.
  int age = today.year - selected.year;
  final bool birthdayPassed =
      (today.month > selected.month) ||
      (today.month == selected.month && today.day >= selected.day);
  if (!birthdayPassed) age--;

  if (age < kMinAgeYears) {
    return 'You must be at least $kMinAgeYears years old to register.';
  }

  return null;
}

// ---------------------------------------------------------------------------
// OTP (structural check only)
// ---------------------------------------------------------------------------

/// Structural check: exactly 6 numeric digits.
///
/// Correct-code verification, shake animation, and the 3-strike lock are
/// handled by [OtpVerifyNotifier]; this function only gates the Verify button.
String? validateOtp(String? raw) {
  final String d = raw?.trim() ?? '';
  if (d.length != 6 || !RegExp(r'^\d{6}$').hasMatch(d)) {
    return 'Enter the 6-digit code sent to your phone.';
  }
  return null;
}

// ---------------------------------------------------------------------------
// Convenience class
// ---------------------------------------------------------------------------

/// Namespace wrapper so callers can write `AuthValidators.phone(v)` without
/// importing individual top-level functions.
abstract final class AuthValidators {
  /// Myanmar phone validator. See [validatePhone].
  static String? phone(String? v) => validatePhone(v);

  /// Required first-name validator. See [validateFirstName].
  static String? firstName(String? v) => validateFirstName(v);

  /// Optional last-name validator. See [validateLastName].
  static String? lastName(String? v) => validateLastName(v);

  /// Date-of-birth validator. See [validateDob].
  static String? dob(DateTime? v) => validateDob(v);

  /// OTP structural validator (6 digits). See [validateOtp].
  static String? otp(String? v) => validateOtp(v);
}
