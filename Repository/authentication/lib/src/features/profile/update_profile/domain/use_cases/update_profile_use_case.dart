import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';
import 'package:auth_module/src/features/profile/update_profile/domain/repositories/update_profile_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>(
  (ref) {
    final repository = ref.read(updateProfileRepositoryProvider);
    return UpdateProfileUseCase(repository: repository);
  },
);

class UpdateProfileUseCase {
  const UpdateProfileUseCase({
    required this.repository,
  });

  final UpdateProfileRepository repository;

  Future<(String, ProfileEntity?)> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return repository.updateMyProfile(
      requestBody: requestBody,
    );
  }
}
