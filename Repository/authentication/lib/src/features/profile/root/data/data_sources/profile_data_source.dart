import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'profile_data_source_impl.dart';

final profileDataSourceProvider = Provider<ProfileDataSource>(
  (ref) {
    return ProfileDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class ProfileDataSource {
  Future<Response> fetchUserProfile(String userId);

  Future<Response> updateMyProfile({
    required Map<String, dynamic> requestBody,
  });

  Future<Response> uploadImage({
    required Map<String, dynamic> requestBody,
  });
}
