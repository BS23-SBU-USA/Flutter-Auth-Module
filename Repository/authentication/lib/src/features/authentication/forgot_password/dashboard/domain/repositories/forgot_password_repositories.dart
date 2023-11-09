// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/data_source/forgot_password_data_source.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/data/repositories/forgot_password_repository_impl.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/entities/forgot_password_entity.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordRepositoryProvider = Provider<ForgotPasswordRepository>(
  (ref) {
    final dataSource = ref.read(forgotPasswordDataSourceProvider);
    final mockUser = ref.read(mockUserProvider);

    return ForgotPasswordRepositoryImp(
      dataSource: dataSource,
      mockUser: mockUser,
    );
  },
);

abstract class ForgotPasswordRepository {
  Future<(String, ForgotPasswordEntity?)> forgotPassword({
    required Map<String, dynamic> requestBody,
  });

  bool offlineEmail({
    required String email,
  });
}
