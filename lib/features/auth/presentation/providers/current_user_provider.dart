import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_provider.dart';
import 'otp_verify_provider.dart';
import 'register_provider.dart';

export '../../domain/entities/user_entity.dart';

final currentUserProvider = Provider<UserEntity?>((ref) {
  final UserEntity? loginUser = ref.watch(loginProvider).value;
  final UserEntity? verifiedUser = ref.watch(otpVerifyProvider).value;
  final UserEntity? registeredUser = ref.watch(registerProvider).value;
  return (registeredUser?.id == verifiedUser?.id ? registeredUser : null) ??
      verifiedUser ??
      loginUser;
});
