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
