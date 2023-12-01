import 'package:auth_module/src/features/authentication/log_out/domain/entities/log_out_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'log_out_local_data_source_impl.dart';

final logOutLocalDataSourceProvider = Provider<LogOutLocalDataSource>(
  (ref) {
    return const LogOutLocalDataSourceImp();
  },
);

abstract class LogOutLocalDataSource {
  Future<Response> logOut();
}
