import 'package:auth_module/src/features/authentication/log_out/domain/entities/log_out_entity.dart';
import 'package:auth_module/src/features/authentication/log_out/domain/repositories/log_out_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logOutUseCaseProvider = Provider<LogOutUseCase>(
  (ref) {
    final repository = ref.read(logOutRepositoryProvider);
    return LogOutUseCase(repository: repository);
  },
);

class LogOutUseCase {
  const LogOutUseCase({required this.repository});

  final LogOutRepository repository;

  Future<(String, LogOutEntity?)> call() async {
    return repository.logOut();
  }
}
