// ignore_for_file: one_member_abstracts

import 'dart:convert';

import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/entities/auth_configure_entity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'sign_in_auth_configure_data_source_impl.dart';

final signInAuthConfigureDataSourceProvider =
    Provider<SignInAuthConfigureDataSource>(
  (ref) {
    return const SignInAuthConfigureDataSourceImp();
  },
);

abstract class SignInAuthConfigureDataSource {
  Future<AuthConfigureEntity> authConfigure();
}
