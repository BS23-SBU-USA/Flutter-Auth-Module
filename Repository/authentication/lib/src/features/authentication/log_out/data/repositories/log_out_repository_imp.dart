import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/log_out/data/data_sources/log_out_data_source_impl.dart';
import 'package:auth_module/src/features/authentication/log_out/data/models/log_out_model.dart';
import 'package:auth_module/src/features/authentication/log_out/domain/entities/log_out_entity.dart';
import 'package:auth_module/src/features/authentication/log_out/domain/repositories/log_out_repositories.dart';

class LogOutRepositoryImp implements LogOutRepository {
  const LogOutRepositoryImp({
    required this.dataSource,
  });

  final LogOutDataSource dataSource;

  @override
  Future<(String, LogOutEntity?)> logOut() async {
    return dataSource.logOut().guard((data) {
      return LogOutModel.fromJson(data);
    });
  }
}
