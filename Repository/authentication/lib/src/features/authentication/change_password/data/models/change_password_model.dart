import 'package:auth_module/src/features/authentication/change_password/domain/entities/change_password_entity.dart';

class ChangePasswordModel extends ChangePasswordEntity {
  ChangePasswordModel({required super.message});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      message: json['message'],
    );
  }
}
