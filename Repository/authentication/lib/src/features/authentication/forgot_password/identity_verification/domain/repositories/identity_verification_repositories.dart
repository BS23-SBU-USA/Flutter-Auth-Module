// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/data_sources/identity_verification_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/data/repositories/identity_verification_repository_impl.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/entities/identity_verification_entity.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final identityVerificationRepositoryProvider =
    Provider<IdentityVerificationRepository>(
  (ref) {
    final dataSource = ref.read(identityVerificationDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return IdentityVerificationRepositoryImp(
      dataSource: dataSource,
      mockUser: mockUser,
    );
  },
);

abstract class IdentityVerificationRepository {
  Future<(String, IdentityVerificationEntity?)> identityVerification({
    required Map<String, dynamic> requestBody,
  });

  bool offlineVerification({
    required String otp,
  });
}
