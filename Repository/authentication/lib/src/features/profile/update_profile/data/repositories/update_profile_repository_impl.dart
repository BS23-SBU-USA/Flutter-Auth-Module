import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/profile/root/data/data_sources/profile_data_source.dart';
import 'package:auth_module/src/features/profile/root/data/models/profile_response_model.dart';
import 'package:auth_module/src/features/profile/root/data/models/upload_image_response_model.dart';
import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';
import 'package:auth_module/src/features/profile/update_profile/domain/repositories/update_profile_repositories.dart';

class UpdateProfileRepositoryImp implements UpdateProfileRepository {
  const UpdateProfileRepositoryImp({
    required this.dataSource,
  });

  final ProfileDataSource dataSource;

  @override
  Future<(String, ProfileEntity?)> updateMyProfile({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource.updateMyProfile(requestBody: requestBody).guard(
      (data) {
        return ProfileResponseModel.fromJson(data).data;
      },
    );
  }

  @override
  Future<(String, UploadImageResponseModel?)> uploadImage({
    required Map<String, dynamic> requestBody,
  }) async {
    return dataSource.uploadImage(requestBody: requestBody).guard(
      (data) {
        return UploadImageResponseModel.fromJson(data);
      },
    );
  }
}
