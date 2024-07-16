import 'package:auth_module/src/features/profile/root/data/data_sources/profile_data_source.dart';
import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';
import 'package:auth_module/src/features/profile/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepositoryImp>(
  (ref) {
    final dataSource = ref.read(profileDataSourceProvider);
    return ProfileRepositoryImp(dataSource: dataSource);
  },
);

abstract class ProfileRepository {
  Future<(String, ProfileEntity?)> fetchUserProfile(String? userId);
}
