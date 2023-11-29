import 'package:auth_module/src/features/authentication/change_password/domain/entities/change_password_entity.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'change_password_local_data_source_impl.dart';

final changePasswordLocalDataSourceProvider =
    Provider<ChangePasswordLocalDataSource>(
  (ref) {
    final mockUser = ref.read(mockUserProvider);
    return ChangePasswordLocalDataSourceImp(
      mockUser: mockUser,
    );
  },
);

abstract class ChangePasswordLocalDataSource {
  Future<Response> changePassword({required Map<String, dynamic> requestBody});
}
