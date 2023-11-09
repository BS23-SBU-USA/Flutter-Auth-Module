import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/data_sources/resend_otp_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/models/resend_otp_model.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/entities/resend_otp_entity.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/repositories/resend_otp_repositories.dart';

class ResendOtpRepositoryImp implements ResendOtpRepository {
  const ResendOtpRepositoryImp({required this.dataSource});

  final ResendOtpDataSource dataSource;

  @override
  Future<(String, ResendOtpEntity?)> resendOtp({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource.resendOtp(requestBody: requestBody).guard((data) {
      return ResendOtpModel.fromJson(data);
    });
  }
}
