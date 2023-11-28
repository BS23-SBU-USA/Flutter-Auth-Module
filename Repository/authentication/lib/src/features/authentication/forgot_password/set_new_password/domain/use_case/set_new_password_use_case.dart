import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/repositories/set_new_password_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setNewPasswordUseCaseProvider = Provider(
  (ref) {
    return SetNewPasswordUseCase(
      ref.read(setNewPasswordRepositoryProvider),
    );
  },
);

class SetNewPasswordUseCase {
  SetNewPasswordUseCase(this.repository);

  final SetNewPasswordRepository repository;

  Future<(String, dynamic)> call({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    return repository.setNewPassword(
      requestBody: requestBody,
      offlineState: offlineState,
    );
  }
}
