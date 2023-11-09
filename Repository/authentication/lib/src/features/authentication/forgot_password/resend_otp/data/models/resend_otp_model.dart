import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/entities/resend_otp_entity.dart';

class ResendOtpModel extends ResendOtpEntity {
  ResendOtpModel({
    required super.message,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpModel(
      message: json['message'],
    );
  }
}
