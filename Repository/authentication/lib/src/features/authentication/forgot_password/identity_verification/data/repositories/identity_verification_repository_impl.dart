import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/data_sources/identity_verification_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/models/identity_verification_model.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/entities/identity_verification_entity.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/repositories/identity_verification_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class IdentityVerificationRepositoryImp
    implements IdentityVerificationRepository {
  const IdentityVerificationRepositoryImp({
    required this.dataSource,
    required this.mockUser,
  });

  final IdentityVerificationDataSource dataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, IdentityVerificationEntity?)> identityVerification({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource
        .identityVerification(requestBody: requestBody)
        .guard((data) {
      return IdentityVerificationModel.fromJson(data);
    });
  }

  @override
  bool offlineVerification({
    required String otp,
  }) {
    Log.debug(otp);
    if (otp == mockUser.otp) {
      return true;
    } else {
      return false;
    }
  }
}
