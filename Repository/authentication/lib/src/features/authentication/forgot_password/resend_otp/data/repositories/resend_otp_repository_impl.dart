import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/data_sources/resend_otp_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/data_sources/resend_otp_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/repositories/resend_otp_repositories.dart';

class ResendOtpRepositoryImp implements ResendOtpRepository {
  const ResendOtpRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final ResendOtpRemoteDataSource remoteDataSource;
  final ResendOtpLocalDataSource localDataSource;

  @override
  Future<(String, dynamic)> resendOtp({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    if (offlineState) {
      final response =
          await localDataSource.resendOtp(requestBody: requestBody);

      return Future.value((response.statusMessage!, true));
    }

    return remoteDataSource.resendOtp(requestBody: requestBody).guard((data) {
      return data;
    });
  }
}
