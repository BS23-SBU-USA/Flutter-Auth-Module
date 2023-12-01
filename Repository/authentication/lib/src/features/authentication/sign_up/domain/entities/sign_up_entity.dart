class SignUpEntity {
  SignUpEntity({
    required this.message,
  });

  String message;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}

class SignUpCredential {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  SignUpCredential({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }
}
