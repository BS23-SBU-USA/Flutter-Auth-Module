import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/entities/resend_otp_entity.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/repositories/resend_otp_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resendOtpUseCaseProvider = Provider(
  (ref) {
    return ResendOtpUseCase(
      ref.read(resendOtpRepositoryProvider),
    );
  },
);

class ResendOtpUseCase {
  ResendOtpUseCase(this.repository);

  final ResendOtpRepository repository;

  Future<(String, ResendOtpEntity?)> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return repository.resendOtp(requestBody: requestBody);
  }
}
