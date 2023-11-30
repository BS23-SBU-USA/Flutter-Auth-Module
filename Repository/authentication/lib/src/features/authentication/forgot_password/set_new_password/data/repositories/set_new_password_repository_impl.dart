import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/data_sources/set_new_password_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/data_sources/set_new_password_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/repositories/set_new_password_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class SetNewPasswordRepositoryImp implements SetNewPasswordRepository {
  const SetNewPasswordRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.mockUser,
  });

  final SetNewPasswordRemoteDataSource remoteDataSource;
  final SetNewPasswordLocalDataSource localDataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, dynamic)> setNewPassword({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    if (offlineState) {
      final response =
          await localDataSource.setNewPassword(requestBody: requestBody);

      if (response.statusMessage == '') {
        mockUser.password = requestBody['password'];
      }
      return Future.value((response.statusMessage!, true));
    }

    return remoteDataSource
        .setNewPassword(requestBody: requestBody)
        .guard((data) {
      return data;
    });
  }
}
