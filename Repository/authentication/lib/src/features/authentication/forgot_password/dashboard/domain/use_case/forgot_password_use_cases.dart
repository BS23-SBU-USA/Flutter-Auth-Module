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

  Future<(String, dynamic)> call({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    return repository.forgotPassword(
      requestBody: requestBody,
      offlineState: offlineState,
    );
  }
}
