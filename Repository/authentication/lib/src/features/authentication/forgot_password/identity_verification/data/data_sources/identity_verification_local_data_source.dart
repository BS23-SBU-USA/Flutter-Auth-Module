import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/entities/identity_verification_entity.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'identity_verification_local_data_source_impl.dart';

final identityVerificationLocalDataSourceProvider =
    Provider<IdentityVerificationLocalDataSource>(
  (ref) {
    final mockUser = ref.read(mockUserProvider);
    return IdentityVerificationLocalDataSourceImp(
      mockUser: mockUser,
    );
  },
);

abstract class IdentityVerificationLocalDataSource {
  Future<Response> identityVerification(
      {required Map<String, dynamic> requestBody});
}
