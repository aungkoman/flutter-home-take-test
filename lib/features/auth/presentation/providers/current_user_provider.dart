import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_provider.dart';
export '../../domain/entities/user_entity.dart';

final currentUserProvider = Provider<UserEntity?>(
  (ref) => ref.watch(sessionProvider).value,
);
