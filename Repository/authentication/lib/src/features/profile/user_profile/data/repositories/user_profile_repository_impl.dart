import 'package:auth_module/src/core/services/network/request_handler.dart';
import 'package:auth_module/src/features/profile/root/data/data_sources/profile_data_source.dart';
import 'package:auth_module/src/features/profile/root/data/models/profile_response_model.dart';
import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';
import 'package:auth_module/src/features/profile/user_profile/domain/repositories/user_profile_repsitories.dart';

class ProfileRepositoryImp implements ProfileRepository {
  const ProfileRepositoryImp({
    required this.dataSource,
  });

  final ProfileDataSource dataSource;

  @override
  Future<(String, ProfileEntity?)> fetchUserProfile(String? userID) async {
    return dataSource.fetchUserProfile(userID!).guard(
      (data) {
        return ProfileResponseModel.fromJson(data).data;
      },
    );
    // return dataSource.fetchUserProfile(userID!).guard(
    //   (data) {
    //     return ProfileResponseModel.fromJson(data).data;
    //   },
    // );
  }
}
