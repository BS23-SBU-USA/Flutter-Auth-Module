import 'package:auth_module/src/features/authentication/sign_up/domain/entities/sign_up_entity.dart';
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

  Future<(String, SignUpEntity?)> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return repository.signUp(requestBody: requestBody);
  }

  void offlineSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    return repository.offlineSignUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }
}
