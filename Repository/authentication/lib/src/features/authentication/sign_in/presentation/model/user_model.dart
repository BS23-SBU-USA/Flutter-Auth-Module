class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.role,
    this.password,
    this.firstName,
    this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      password: json['password'],
      firstName: json['firstname'],
      lastName: json['lastname'],
    );
  }

  String id;
  String email;
  String role;
  String? password;
  String? firstName;
  String? lastName;
}
