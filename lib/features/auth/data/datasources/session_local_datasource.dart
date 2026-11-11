import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionLocalDatasource {
  Future<int?> readUserId();
  Future<void> writeUserId(int userId);
  Future<void> clear();
}

/// Stores the authenticated account ID; the local database owns profile data.
class SecureSessionLocalDatasource implements SessionLocalDatasource {
  SecureSessionLocalDatasource({required this.storage});

  static const String _userIdKey = 'auth.session.user_id';
  final FlutterSecureStorage storage;

  @override
  Future<int?> readUserId() async {
    final String? value = await storage.read(key: _userIdKey);
    if (value == null) return null;
    final int? userId = int.tryParse(value);
    if (userId == null || userId <= 0) {
      await clear();
      return null;
    }
    return userId;
  }

  @override
  Future<void> writeUserId(int userId) =>
      storage.write(key: _userIdKey, value: userId.toString());

  @override
  Future<void> clear() => storage.delete(key: _userIdKey);
}
