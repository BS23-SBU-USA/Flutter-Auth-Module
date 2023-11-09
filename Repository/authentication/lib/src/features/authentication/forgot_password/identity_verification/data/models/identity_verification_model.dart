import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/entities/identity_verification_entity.dart';

class IdentityVerificationModel extends IdentityVerificationEntity {
  IdentityVerificationModel({required super.message});

  factory IdentityVerificationModel.fromJson(Map<String, dynamic> json) {
    return IdentityVerificationModel(
      message: json['message'],
    );
  }
}
