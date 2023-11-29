import 'package:auth_module/src/features/authentication/change_password/domain/repositories/change_password_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changePasswordUseCaseProvider = Provider(
  (ref) {
    return ChangePasswordUseCase(
      ref.read(changePasswordRepositoryProvider),
    );
  },
);

class ChangePasswordUseCase {
  const ChangePasswordUseCase(this.repository);

  final ChangePasswordRepository repository;

  Future<(String, dynamic)> call({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    return repository.changePassword(
      requestBody: requestBody,
      offlineState: offlineState,
    );
  }
}
