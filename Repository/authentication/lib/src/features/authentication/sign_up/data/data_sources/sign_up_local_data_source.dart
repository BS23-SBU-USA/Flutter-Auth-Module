// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'sign_up_local_data_source_impl.dart';

final signUpLocalDataSourceProvider = Provider<SignUpLocalDataSource>(
  (ref) {
    return const SignUpLocalDataSourceImp();
  },
);

abstract class SignUpLocalDataSource {
  Future<Response> signUp({required Map<String, dynamic> requestBody});
}
