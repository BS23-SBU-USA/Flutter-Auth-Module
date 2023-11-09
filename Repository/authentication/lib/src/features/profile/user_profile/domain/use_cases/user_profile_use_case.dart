import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';
import 'package:auth_module/src/features/profile/user_profile/domain/repositories/user_profile_repsitories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileUseCaseProvider = Provider<UserProfileUseCase>(
  (ref) {
    final repository = ref.read(profileRepositoryProvider);
    return UserProfileUseCase(repository: repository);
  },
);

class UserProfileUseCase {
  const UserProfileUseCase({
    required this.repository,
  });

  final ProfileRepository repository;

  Future<(String, ProfileEntity?)> call(String? userID) async {
    return repository.fetchUserProfile(userID);
  }
}
