// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/data_sources/set_new_password_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/data/repositories/set_new_password_repository_impl.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/entities/set_new_password_entity.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setNewPasswordRepositoryProvider = Provider<SetNewPasswordRepository>(
  (ref) {
    final dataSource = ref.read(setNewPasswordDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return SetNewPasswordRepositoryImp(
      dataSource: dataSource,
      mockUser: mockUser,
    );
  },
);

abstract class SetNewPasswordRepository {
  Future<(String, SetNewPasswordEntity?)> setNewPassword({
    required Map<String, dynamic> requestBody,
  });

  void offlineNewPassword({
    required String password,
  });
}
