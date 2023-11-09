import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/models/sign_up_model.dart';
import 'package:auth_module/src/features/authentication/sign_up/domain/entities/sign_up_entity.dart';
import 'package:auth_module/src/features/authentication/sign_up/domain/repositories/sign_up_repositories.dart';

class SignUpRepositoryImp implements SignUpRepository {
  const SignUpRepositoryImp({
    required this.dataSource,
    required this.mockUser,
  });

  final SignUpDataSource dataSource;
  final MockUserModel mockUser;

  @override
  Future<(String, SignUpEntity?)> signUp({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource.signUp(requestBody: requestBody).guard((data) {
      return SignUpModel.fromJson(data);
    });
  }

  @override
  void offlineSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    Log.debug('$firstName,  $lastName,  $email,  $password');

    mockUser.firstName = firstName;
    mockUser.lastName = lastName;
    mockUser.email = email;
    mockUser.password = password;

    Log.debug('${mockUser.firstName}\n'
        '${mockUser.lastName}\n'
        '${mockUser.email}\n'
        '${mockUser.password}');
  }
}
