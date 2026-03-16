class UserModel {

  String name;
  String email;
  String mobile;
  String gender;
  String password;

  UserModel({
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.password,
  });

  Map<String, dynamic> toJson() {

    return {
      "name": name,
      "email": email,
      "mobile": mobile,
      "gender": gender,
      "password": password,
    };

  }

}