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

  Future<(String, dynamic)> call({
    required bool offlineState,
  }) async {
    return repository.logOut(
      offlineState: offlineState,
    );
  }
}
