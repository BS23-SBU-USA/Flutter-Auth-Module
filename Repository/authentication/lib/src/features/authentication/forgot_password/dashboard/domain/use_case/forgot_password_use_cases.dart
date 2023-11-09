import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/entities/forgot_password_entity.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/repositories/forgot_password_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordUseCaseProvider = Provider(
  (ref) {
    return ForgotPasswordUseCase(
      ref.read(forgotPasswordRepositoryProvider),
    );
  },
);

class ForgotPasswordUseCase {
  ForgotPasswordUseCase(this.repository);

  final ForgotPasswordRepository repository;

  Future<(String, ForgotPasswordEntity?)> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return repository.forgotPassword(requestBody: requestBody);
  }

  bool offlineEmail({
    required String email,
  }) {
    return repository.offlineEmail(
      email: email,
    );
  }
}
