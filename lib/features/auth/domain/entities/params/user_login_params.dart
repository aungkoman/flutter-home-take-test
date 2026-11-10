
class UserLoginParams{
  String phone;

  UserLoginParams({
    required this.phone,
  });

  static UserLoginParams get sample{
    return UserLoginParams(phone: "test@email.com");
  }

  Map<String,dynamic> toJson(){
    return {
      "phone" : phone
    };
  }
}