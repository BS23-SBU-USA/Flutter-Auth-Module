import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/data_sources/sign_up_local_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpRepositoryProvider = Provider<SignUpRepository>(
  (ref) {
    final remoteDataSource = ref.read(signUpRemoteDataSourceProvider);
    final localDataSource = ref.read(signUpLocalDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return SignUpRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      mockUser: mockUser,
    );
  },
);

abstract class SignUpRepository {
  Future<(String, dynamic)> signUp({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
  });
}
