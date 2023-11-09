// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/data_sources/resend_otp_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/data/repositories/resend_otp_repository_impl.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/entities/resend_otp_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resendOtpRepositoryProvider = Provider<ResendOtpRepository>(
  (ref) {
    final dataSource = ref.read(resendOtpDataSourceProvider);

    return ResendOtpRepositoryImp(dataSource: dataSource);
  },
);

abstract class ResendOtpRepository {
  Future<(String, ResendOtpEntity?)> resendOtp({
    required Map<String, dynamic> requestBody,
  });
}
