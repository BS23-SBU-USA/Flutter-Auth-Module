import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/data_sources/identity_verification_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/data_sources/identity_verification_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/repositories/identity_verification_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class IdentityVerificationRepositoryImp
    implements IdentityVerificationRepository {
  const IdentityVerificationRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.mockUser,
  });

  final IdentityVerificationRemoteDataSource remoteDataSource;
  final IdentityVerificationLocalDataSource localDataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, dynamic)> identityVerification({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  }) async {
    if (offlineState) {
      final response =
          await localDataSource.identityVerification(requestBody: requestBody);

      return Future.value((response.statusMessage!, true));
    }

    return remoteDataSource
        .identityVerification(requestBody: requestBody)
        .guard((data) {
      return data;
    });
  }
}
