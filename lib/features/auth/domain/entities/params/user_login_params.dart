enum AuthEntryMode { login, register }

class UserLoginParams {
  UserLoginParams({required this.phone, this.mode = AuthEntryMode.login});
  final String phone;
  final AuthEntryMode mode;

  static UserLoginParams get sample => UserLoginParams(phone: '+959123456781');

  Map<String, dynamic> toJson() => {'phone': phone};
}
