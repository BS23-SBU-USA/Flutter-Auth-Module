// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/features/profile/root/data/data_sources/profile_data_source.dart';
import 'package:auth_module/src/features/profile/root/data/models/upload_image_response_model.dart';
import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';
import 'package:auth_module/src/features/profile/update_profile/data/repositories/update_profile_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateProfileRepositoryProvider = Provider<UpdateProfileRepository>(
  (ref) {
    final dataSource = ref.read(profileDataSourceProvider);
    return UpdateProfileRepositoryImp(dataSource: dataSource);
  },
);

abstract class UpdateProfileRepository {
  Future<(String, ProfileEntity?)> updateMyProfile({
    required Map<String, dynamic> requestBody,
  });

  Future<(String, UploadImageResponseModel?)> uploadImage({
    required Map<String, dynamic> requestBody,
  });
}
