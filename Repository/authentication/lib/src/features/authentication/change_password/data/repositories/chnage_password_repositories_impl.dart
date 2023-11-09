import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/change_password/data/data_sources/change_password_data_source.dart';
import 'package:auth_module/src/features/authentication/change_password/data/models/change_password_model.dart';
import 'package:auth_module/src/features/authentication/change_password/domain/entities/change_password_entity.dart';
import 'package:auth_module/src/features/authentication/change_password/domain/repositories/change_password_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class ChangePasswordRepositoryImp implements ChangePasswordRepository {
  const ChangePasswordRepositoryImp({
    required this.dataSource,
    required this.mockUser,
  });

  final ChangePasswordDataSource dataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, ChangePasswordEntity?)> changePassword({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource.changePassword(requestBody: requestBody).guard((data) {
      return ChangePasswordModel.fromJson(
        data,
      );
    });
  }

  @override
  void offlineNewPassword({
    required String password,
  }) {
    Log.debug(password);
    mockUser.password = password;
  }
}
