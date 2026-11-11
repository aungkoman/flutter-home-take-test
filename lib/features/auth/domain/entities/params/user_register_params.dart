class UserRegisterParams {
  int userId;
  String firstName;
  String lastName;
  String dob;
  String phone;

  UserRegisterParams({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.phone,
  });

  static UserRegisterParams get sample {
    return UserRegisterParams(
      userId: 0,
      phone: "test@email.com",
      firstName: "First Name",
      lastName: "Last Name",
      dob: "1990-10-13",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "first_name": firstName,
      "last_name": lastName,
      "dob": dob,
      "phone": phone,
    };
  }
}
