// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/core/services/auth_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'sign_in_sso_data_source_impl.dart';

final ssoSignInDataSourceProvider = Provider<SSOSignInDataSource>(
  (ref) {
    return const SSOSignInDataSourceImp();
  },
);

abstract class SSOSignInDataSource {
  Future<Response> ssoSignIn({required BuildContext context});
}
