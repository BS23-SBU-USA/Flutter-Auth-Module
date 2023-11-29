import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/change_password/data/change_password_data_source/change_password_local_data_source.dart';
import 'package:auth_module/src/features/authentication/change_password/data/change_password_data_source/change_password_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/change_password/domain/repositories/change_password_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class ChangePasswordRepositoryImp implements ChangePasswordRepository {
  const ChangePasswordRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.mockUser,
  });

  final ChangePasswordRemoteDataSource remoteDataSource;
  final ChangePasswordLocalDataSource localDataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, dynamic)> changePassword({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    if (offlineState) {
      mockUser.password = requestBody['newPassword'];
      final response = await localDataSource.changePassword(
        requestBody: requestBody,
      );
      return Future.value((response.statusMessage!, true));
    }

    return remoteDataSource
        .changePassword(requestBody: requestBody)
        .guard((data) {
      return data;
    });
  }
}
