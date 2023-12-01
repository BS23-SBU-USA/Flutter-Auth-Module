import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/entities/resend_otp_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'resend_otp_local_data_source_impl.dart';

final resendOtpLocalDataSourceProvider = Provider<ResendOtpLocalDataSource>(
  (ref) {
    return const ResendOtpLocalDataSourceImp();
  },
);

abstract class ResendOtpLocalDataSource {
  Future<Response> resendOtp({required Map<String, dynamic> requestBody});
}
