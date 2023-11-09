// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:auth_module/src/features/authentication/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpRepositoryProvider = Provider<SignUpRepository>(
  (ref) {
    final dataSource = ref.read(signUpDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);
    return SignUpRepositoryImp(
      dataSource: dataSource,
      mockUser: mockUser,
    );
  },
);

abstract class SignUpRepository {
  Future<(String, SignUpEntity?)> signUp({
    required Map<String, dynamic> requestBody,
  });

  void offlineSignUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
}
