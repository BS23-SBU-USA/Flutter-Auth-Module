import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/entities/set_new_password_entity.dart';

class SetNewPasswordModel extends SetNewPasswordEntity {
  SetNewPasswordModel({
    required super.message,
  });

  factory SetNewPasswordModel.fromJson(Map<String, dynamic> json) {
    return SetNewPasswordModel(
      message: json['message'],
    );
  }
}
