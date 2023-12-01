import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/repositories/identity_verification_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final identityVerificationUseCaseProvider = Provider(
  (ref) {
    return IdentityVerificationUseCase(
      ref.read(identityVerificationRepositoryProvider),
    );
  },
);

class IdentityVerificationUseCase {
  IdentityVerificationUseCase(this.repository);

  final IdentityVerificationRepository repository;

  Future<(String, dynamic)> call({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    return repository.identityVerification(
      requestBody: requestBody,
      offlineState: offlineState,
    );
  }
}
