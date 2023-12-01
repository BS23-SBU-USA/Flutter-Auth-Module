// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/entities/sign_in_entity.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/model/user_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'sign_in_local_data_source_impl.dart';

final signInLocalDataSourceProvider = Provider<SignInLocalDataSource>(
  (ref) {
    final mockUser = ref.read(mockUserProvider);
    return SignInLocalDataSourceImp(
      mockUser: mockUser,
    );
  },
);

abstract class SignInLocalDataSource {
  Future<Response> signIn({required Map<String, dynamic> requestBody});
}
