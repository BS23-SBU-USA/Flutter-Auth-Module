// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/change_password/data/change_password_data_source/change_password_local_data_source.dart';
import 'package:auth_module/src/features/authentication/change_password/data/change_password_data_source/change_password_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/change_password/data/repositories/chnage_password_repositories_impl.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changePasswordRepositoryProvider = Provider<ChangePasswordRepository>(
  (ref) {
    final remoteDataSource = ref.read(changePasswordRemoteDataSourceProvider);
    final localDataSource = ref.read(changePasswordLocalDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return ChangePasswordRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      mockUser: mockUser,
    );
  },
);

abstract class ChangePasswordRepository {
  Future<(String, dynamic)> changePassword({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  });
}
