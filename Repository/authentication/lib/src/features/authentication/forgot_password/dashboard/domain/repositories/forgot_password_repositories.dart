// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/data_source/forgot_password_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/data_source/forgot_password_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/repositories/forgot_password_repository_impl.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordRepositoryProvider = Provider<ForgotPasswordRepository>(
  (ref) {
    final remoteDataSource = ref.read(forgotPasswordRemoteDataSourceProvider);
    final localDataSource = ref.read(forgotPasswordLocalDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return ForgotPasswordRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      mockUser: mockUser,
    );
  },
);

abstract class ForgotPasswordRepository {
  Future<(String, dynamic)> forgotPassword({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  });
}
