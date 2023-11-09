import 'package:auth_module/src/features/authentication/change_password/domain/entities/change_password_entity.dart';
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

  Future<(String, ChangePasswordEntity?)> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return repository.changePassword(
      requestBody: requestBody,
    );
  }

  void offlineNewPassword({
    required String password,
  }) {
    return repository.offlineNewPassword(
      password: password,
    );
  }
}
