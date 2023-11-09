// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/change_password/data/data_sources/change_password_data_source.dart';
import 'package:auth_module/src/features/authentication/change_password/data/repositories/chnage_password_repositories_impl.dart';
import 'package:auth_module/src/features/authentication/change_password/domain/entities/change_password_entity.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changePasswordRepositoryProvider = Provider<ChangePasswordRepository>(
  (ref) {
    final dataSource = ref.read(changePasswordDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return ChangePasswordRepositoryImp(
      dataSource: dataSource,
      mockUser: mockUser,
    );
  },
);

abstract class ChangePasswordRepository {
  Future<(String, ChangePasswordEntity?)> changePassword({
    required Map<String, dynamic> requestBody,
  });

  void offlineNewPassword({
    required String password,
  });
}
