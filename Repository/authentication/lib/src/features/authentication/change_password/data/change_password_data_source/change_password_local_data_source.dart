import 'package:auth_module/src/features/authentication/change_password/domain/entities/change_password_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'change_password_local_data_source_impl.dart';

final changePasswordLocalDataSourceProvider =
    Provider<ChangePasswordLocalDataSource>(
  (ref) {
    return const ChangePasswordLocalDataSourceImp();
  },
);

abstract class ChangePasswordLocalDataSource {
  Future<Response> changePassword({required Map<String, dynamic> requestBody});
}
