// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/data_sources/set_new_password_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/data_sources/set_new_password_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/repositories/set_new_password_repository_impl.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setNewPasswordRepositoryProvider = Provider<SetNewPasswordRepository>(
  (ref) {
    final remoteDataSource = ref.read(setNewPasswordRemoteDataSourceProvider);
    final localDataSource = ref.read(setNewPasswordLocalDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return SetNewPasswordRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      mockUser: mockUser,
    );
  },
);

abstract class SetNewPasswordRepository {
  Future<(String, dynamic)> setNewPassword({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  });
}
