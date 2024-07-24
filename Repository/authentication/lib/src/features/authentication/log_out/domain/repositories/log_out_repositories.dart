import 'package:auth_module/src/features/authentication/log_out/data/data_sources/log_out_local_data_source.dart';
import 'package:auth_module/src/features/authentication/log_out/data/data_sources/log_out_remote_data_source_impl.dart';
import 'package:auth_module/src/features/authentication/log_out/data/repositories/log_out_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logOutRepositoryProvider = Provider<LogOutRepository>(
  (ref) {
    final remoteDataSource = ref.read(logOutRemoteDataSourceProvider);
    final localDataSource = ref.read(logOutLocalDataSourceProvider);

    return LogOutRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  },
);

abstract class LogOutRepository {
  Future<(String, dynamic)> logOut({
    required bool offlineState,
  });
}
