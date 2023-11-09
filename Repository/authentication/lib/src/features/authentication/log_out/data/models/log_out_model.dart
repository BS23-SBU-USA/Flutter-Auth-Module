import 'package:auth_module/src/features/authentication/log_out/domain/entities/log_out_entity.dart';

class LogOutModel extends LogOutEntity {
  LogOutModel({
    required super.message,
  });
  factory LogOutModel.fromJson(Map<String, dynamic> json) => LogOutModel(
        message: json['message'],
      );
}
