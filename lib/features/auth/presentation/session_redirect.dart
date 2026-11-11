import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/user_entity.dart';

String? sessionRedirect(AsyncValue<UserEntity?> session, String path) {
  if (session.isLoading || session.hasError) {
    return path == '/session' ? null : '/session';
  }
  const List<String> publicPaths = ['/', '/login', '/otp', '/register'];
  if (session.value == null) {
    return publicPaths.contains(path) ? null : '/';
  }
  // Registration saves its session before navigating to Welcome.
  if (path == '/' || path == '/login' || path == '/otp' || path == '/session') {
    return '/home';
  }
  return null;
}
