import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/data_sources/set_new_password_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/models/set_new_password_model.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/entities/set_new_password_entity.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/repositories/set_new_password_repositories.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';

class SetNewPasswordRepositoryImp implements SetNewPasswordRepository {
  const SetNewPasswordRepositoryImp({
    required this.dataSource,
    required this.mockUser,
  });

  final SetNewPasswordDataSource dataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, SetNewPasswordEntity?)> setNewPassword({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource.setNewPassword(requestBody: requestBody).guard((data) {
      return SetNewPasswordModel.fromJson(data);
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
