import 'package:auth_module/src/features/authentication/sign_in/domain/entities/sign_in_entity.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/model/user_model.dart';

class SignInModel extends SignInEntity {
  SignInModel({
    required super.message,
    required super.token,
    required super.user,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      message: json['message'],
      token: json['token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
