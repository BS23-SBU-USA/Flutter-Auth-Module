import 'dart:async';

import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/data_sources/sign_in_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/entities/sign_in_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInRepositoryProvider = Provider<SignInRepository>(
  (ref) {
    final dataSource = ref.read(signInDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return SignInRepositoryImp(
      dataSource: dataSource,
      mockUser: mockUser,
    );
  },
);

abstract class SignInRepository {
  Future<(String?, SignInEntity?)> signIn({
    required String email,
    required String password,
    required bool rememberMeState,
  });

  Future<Map<String, dynamic>?> getStoredCredentials();
  Future<void> storeNecessaryInfo({required SignInEntity entity});

  bool offlineSignIn({
    required String email,
    required String password,
    required bool rememberMeState,
  });

  Future<String?> decideNextRoute();
}
