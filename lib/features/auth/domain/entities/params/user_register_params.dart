
class UserRegisterParams{
  String phone;

  UserRegisterParams({
    required this.phone,
  });

  static UserRegisterParams get sample{
    return UserRegisterParams(phone: "test@email.com");
  }

  Map<String,dynamic> toJson(){
    return {
      "phone" : phone
    };
  }
}