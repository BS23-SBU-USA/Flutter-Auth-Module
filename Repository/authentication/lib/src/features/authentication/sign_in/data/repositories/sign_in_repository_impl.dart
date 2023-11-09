import 'dart:async';

import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/core/services/device_info/device_info_service.dart';
import 'package:auth_module/src/core/services/local_storage/cache_service.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/data_sources/sign_in_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/models/sign_in_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/entities/sign_in_entity.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/repositories/sign_in_repositories.dart';

class SignInRepositoryImp implements SignInRepository {
  SignInRepositoryImp({
    required this.dataSource,
    required this.mockUser,
  });

  final SignInDataSource dataSource;
  final MockUserModel mockUser;

  @override
  Future<(String?, SignInEntity?)> signIn({
    required String email,
    required String password,
    required bool rememberMeState,
  }) async {
    manageCredentials(
      email: email,
      password: password,
      rememberMeState: rememberMeState,
    );

    final deviceOS = await DeviceInfoService().getDeviceOS();
    final deviceModel = await DeviceInfoService().getDeviceModel();

    final requestBody = <String, dynamic>{
      'email': email,
      'password': password,
      'OS': deviceOS,
      'model': deviceModel,
      'FCMToken': 'Token',
    };

    return dataSource.signIn(requestBody: requestBody).guard((data) {
      final SignInEntity entity = SignInModel.fromJson(data);
      CacheService.instance.storeBearerToken(entity.token);
      CacheService.instance.storeProfileId(entity.user.id);
      CacheService.instance.storeFullName(
        entity.user.firstName!,
        entity.user.lastName!,
      );
      return entity;
    });
  }

  @override
  Future<String?> decideNextRoute() async {
    final token = await CacheService.instance.retrieveBearerToken();

    return token;
  }

  @override
  Future<Map<String, dynamic>?> getStoredCredentials() async {
    final credentials = await CacheService.instance.retrieveCredentials();

    if (credentials != null) {
      return credentials;
    }

    return null;
  }

  @override
  bool offlineSignIn({
    required String email,
    required String password,
    required bool rememberMeState,
  }) {
    manageCredentials(
      email: email,
      password: password,
      rememberMeState: rememberMeState,
    );

    Log.debug('$email  $password');
    if (email == mockUser.email && password == mockUser.password) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> manageCredentials({
    required String email,
    required String password,
    required bool rememberMeState,
  }) async {
    if (rememberMeState) {
      await CacheService.instance.storeCredentials({
        'userEmail': email,
        'password': password,
      });
    } else {
      await CacheService.instance.clearCredentials();
    }
  }
}
