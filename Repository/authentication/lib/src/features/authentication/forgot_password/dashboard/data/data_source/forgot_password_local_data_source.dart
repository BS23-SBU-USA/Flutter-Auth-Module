import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/entities/forgot_password_entity.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'forgot_password_local_data_source_impl.dart';

final forgotPasswordLocalDataSourceProvider =
    Provider<ForgotPasswordLocalDataSource>(
  (ref) {
    final mockUser = ref.read(mockUserProvider);
    return ForgotPasswordLocalDataSourceImp(
      mockUser: mockUser,
    );
  },
);

abstract class ForgotPasswordLocalDataSource {
  Future<Response> forgotPassword({required Map<String, dynamic> requestBody});
}
