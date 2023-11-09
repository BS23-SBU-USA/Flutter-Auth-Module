// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/log_out/data/data_sources/log_out_data_source_impl.dart';
import 'package:auth_module/src/features/authentication/log_out/data/repositories/log_out_repository_imp.dart';
import 'package:auth_module/src/features/authentication/log_out/domain/entities/log_out_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logOutRepositoryProvider = Provider<LogOutRepository>(
  (ref) {
    final dataSource = ref.read(logOutDataSourceProvider);
    return LogOutRepositoryImp(dataSource: dataSource);
  },
);

abstract class LogOutRepository {
  Future<(String, LogOutEntity?)> logOut();
}
