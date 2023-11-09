import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/entities/forgot_password_entity.dart';

class ForgotPasswordModel extends ForgotPasswordEntity {
  ForgotPasswordModel({required super.message});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      message: json['message'],
    );
  }
}
