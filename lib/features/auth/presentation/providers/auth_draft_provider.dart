import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/validators/auth_validators.dart';

class AuthDraft {
  const AuthDraft({
    this.phone = '',
    this.firstName = '',
    this.lastName = '',
    this.dob,
  });
  final String phone;
  final String firstName;
  final String lastName;
  final DateTime? dob;
}

final authDraftProvider = NotifierProvider<AuthDraftNotifier, AuthDraft>(
  AuthDraftNotifier.new,
);

/// Keeps unfinished form input when users return to an earlier route.
class AuthDraftNotifier extends Notifier<AuthDraft> {
  @override
  AuthDraft build() => const AuthDraft();

  void setPhone(String phone) {
    final bool sameAccount =
        canonicalizePhone(phone) == canonicalizePhone(state.phone);
    state = AuthDraft(
      phone: phone,
      firstName: sameAccount ? state.firstName : '',
      lastName: sameAccount ? state.lastName : '',
      dob: sameAccount ? state.dob : null,
    );
  }

  void setNames(String firstName, String lastName) {
    state = AuthDraft(
      phone: state.phone,
      firstName: firstName,
      lastName: lastName,
      dob: state.dob,
    );
  }

  void setDob(DateTime dob) {
    state = AuthDraft(
      phone: state.phone,
      firstName: state.firstName,
      lastName: state.lastName,
      dob: dob,
    );
  }
}
