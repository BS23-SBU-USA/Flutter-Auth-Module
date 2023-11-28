import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/data_source/forgot_password_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/data_source/forgot_password_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/repositories/forgot_password_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class ForgotPasswordRepositoryImp implements ForgotPasswordRepository {
  const ForgotPasswordRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.mockUser,
  });

  final ForgotPasswordRemoteDataSource remoteDataSource;
  final ForgotPasswordLocalDataSource localDataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, dynamic)> forgotPassword({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    if (offlineState) {
      final response =
          await localDataSource.forgotPassword(requestBody: requestBody);

      return Future.value((response.statusMessage!, true));
    }

    return remoteDataSource
        .forgotPassword(requestBody: requestBody)
        .guard((data) {
      return data;
    });
  }
}
