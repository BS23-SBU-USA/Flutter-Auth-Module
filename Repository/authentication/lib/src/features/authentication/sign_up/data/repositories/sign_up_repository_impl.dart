import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/data_sources/sign_up_local_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_up/domain/repositories/sign_up_repositories.dart';

class SignUpRepositoryImp implements SignUpRepository {
  const SignUpRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.mockUser,
  });

  final SignUpRemoteDataSource remoteDataSource;
  final SignUpLocalDataSource localDataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, dynamic)> signUp({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    if (offlineState) {
      final response = await localDataSource.signUp(requestBody: requestBody);

      if (response.statusMessage == '') {
        mockUser.firstName = requestBody['firstname'];
        mockUser.lastName = requestBody['lastname'];
        mockUser.email = requestBody['email'];
        mockUser.password = requestBody['password'];
      }

      return Future.value((response.statusMessage!, true));
    }

    return remoteDataSource.signUp(requestBody: requestBody).guard((data) {
      return data;
    });
  }
}
