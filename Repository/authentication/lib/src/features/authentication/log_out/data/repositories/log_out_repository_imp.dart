import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/log_out/data/data_sources/log_out_local_data_source.dart';
import 'package:auth_module/src/features/authentication/log_out/data/data_sources/log_out_remote_data_source_impl.dart';
import 'package:auth_module/src/features/authentication/log_out/domain/repositories/log_out_repositories.dart';

class LogOutRepositoryImp implements LogOutRepository {
  const LogOutRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final LogOutRemoteDataSource remoteDataSource;
  final LogOutLocalDataSource localDataSource;

  @override
  Future<(String, dynamic)> logOut({
    required bool offlineState,
  }) async {
    if (offlineState) {
      final response = await localDataSource.logOut();
      return Future.value((response.statusMessage!, true));
    }

    return remoteDataSource.logOut().guard((data) {
      return data;
    });
  }
}
