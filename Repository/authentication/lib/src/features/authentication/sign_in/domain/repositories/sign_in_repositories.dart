import 'dart:async';

import 'package:auth_module/src/features/authentication/sign_in/data/data_sources/sign_in_local_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInRepositoryProvider = Provider<SignInRepository>(
  (ref) {
    final remoteDataSource = ref.read(signInRemoteDataSourceProvider);
    final localDataSource = ref.read(signInLocalDataSourceProvider);

    return SignInRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  },
);

abstract class SignInRepository {
  Future<(String, dynamic)> signIn({
    required Map<String, dynamic> requestBody,
    required bool offlineState,
    required bool rememberMeState,
  });

  Future<Map<String, dynamic>?> getStoredCredentials();

  Future<String?> decideNextRoute();
}
