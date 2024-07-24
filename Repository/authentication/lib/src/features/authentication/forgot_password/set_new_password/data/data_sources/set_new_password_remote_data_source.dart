import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'set_new_password_remote_data_source_impl.dart';

final setNewPasswordRemoteDataSourceProvider =
    Provider<SetNewPasswordRemoteDataSource>(
  (ref) {
    return SetNewPasswordRemoteDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class SetNewPasswordRemoteDataSource {
  Future<Response> setNewPassword({required Map<String, dynamic> requestBody});
}
