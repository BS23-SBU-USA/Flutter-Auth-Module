// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/data_sources/identity_verification_local_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/data_sources/identity_verification_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/repositories/identity_verification_repository_impl.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final identityVerificationRepositoryProvider =
    Provider<IdentityVerificationRepository>(
  (ref) {
    final remoteDataSource =
        ref.read(identityVerificationRemoteDataSourceProvider);
    final localDataSource =
        ref.read(identityVerificationLocalDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return IdentityVerificationRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      mockUser: mockUser,
    );
  },
);

abstract class IdentityVerificationRepository {
  Future<(String, dynamic)> identityVerification({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  });
}
