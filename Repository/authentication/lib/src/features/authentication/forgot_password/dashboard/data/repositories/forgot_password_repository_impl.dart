import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/data_source/forgot_password_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/models/forgot_password_model.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/entities/forgot_password_entity.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/repositories/forgot_password_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class ForgotPasswordRepositoryImp implements ForgotPasswordRepository {
  const ForgotPasswordRepositoryImp({
    required this.dataSource,
    required this.mockUser,
  });

  final ForgotPasswordDataSource dataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, ForgotPasswordEntity?)> forgotPassword({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource.forgotPassword(requestBody: requestBody).guard((data) {
      return ForgotPasswordModel.fromJson(data);
    });
  }

  @override
  bool offlineEmail({
    required String email,
  }) {
    Log.debug(email);
    if (email == mockUser.email) {
      return true;
    } else {
      return false;
    }
  }
}
