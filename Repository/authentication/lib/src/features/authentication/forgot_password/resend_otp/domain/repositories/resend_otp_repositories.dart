// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/data_sources/resend_otp_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/data_sources/resend_otp_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/repositories/resend_otp_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resendOtpRepositoryProvider = Provider<ResendOtpRepository>(
  (ref) {
    final remoteDataSource = ref.read(resendOtpRemoteDataSourceProvider);
    final localDataSource = ref.read(resendOtpLocalDataSourceProvider);

    return ResendOtpRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  },
);

abstract class ResendOtpRepository {
  Future<(String, dynamic)> resendOtp({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  });
}
