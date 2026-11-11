class UserOtpVerifyParams {
  int userId;
  String otpCode;

  UserOtpVerifyParams({required this.userId, required this.otpCode});

  static UserOtpVerifyParams get sample {
    return UserOtpVerifyParams(userId: 0, otpCode: "123456");
  }

  Map<String, dynamic> toJson() {
    return {"user_id": 0, "otp_code": "123456"};
  }
}
