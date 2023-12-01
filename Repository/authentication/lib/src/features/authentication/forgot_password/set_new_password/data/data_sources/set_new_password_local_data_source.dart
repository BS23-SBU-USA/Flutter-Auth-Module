import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/entities/set_new_password_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'set_new_password_local_data_source_impl.dart';

final setNewPasswordLocalDataSourceProvider =
    Provider<SetNewPasswordLocalDataSource>(
  (ref) {
    return const SetNewPasswordLocalDataSourceImp();
  },
);

abstract class SetNewPasswordLocalDataSource {
  Future<Response> setNewPassword({required Map<String, dynamic> requestBody});
}
