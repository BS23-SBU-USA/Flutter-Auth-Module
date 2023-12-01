import 'package:auth_module/src/features/authentication/sign_in/presentation/model/user_model.dart';

class SignInEntity {
  SignInEntity({
    required this.message,
    required this.token,
    required this.user,
  });

  String message;
  String token;
  UserModel user;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }
}

class SignInCredential {
  final String email;
  final String password;

  SignInCredential({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class UserCredential {
  final String email;
  final String password;
  final String deviceOS;
  final String deviceModel;
  final String fcmToken;

  UserCredential({
    required this.email,
    required this.password,
    required this.deviceOS,
    required this.deviceModel,
    required this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'OS': deviceOS,
      'model': deviceModel,
      'FCMToken': fcmToken,
    };
  }
}
