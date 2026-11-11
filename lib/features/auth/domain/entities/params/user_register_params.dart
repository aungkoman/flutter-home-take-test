
class UserRegisterParams{
  String firstName;
  String lastName;
  String dob;
  String phone;

  UserRegisterParams({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phone,
  });

  static UserRegisterParams get sample{
    return UserRegisterParams(phone: "test@email.com", firstName: "First Name", lastName: "Last Name", dob: "1990-10-13");
  }

  Map<String,dynamic> toJson(){
    return {
      "first_name" : firstName,
      "last_name" : lastName,
      "dob" : dob,
      "phone" : phone,
    };
  }
}