import 'package:auth_module/src/features/authentication/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpUseCaseProvider = Provider<SignUpUseCase>(
  (ref) {
    final repository = ref.read(signUpRepositoryProvider);
    return SignUpUseCase(repository: repository);
  },
);

class SignUpUseCase {
  const SignUpUseCase({required this.repository});

  final SignUpRepository repository;

  Future<(String, dynamic)> call({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    return repository.signUp(
      requestBody: requestBody,
      offlineState: offlineState,
    );
  }
}
