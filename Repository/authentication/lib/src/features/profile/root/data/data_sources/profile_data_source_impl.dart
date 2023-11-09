part of 'profile_data_source.dart';

class ProfileDataSourceImp implements ProfileDataSource {
  const ProfileDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> fetchUserProfile(String userId) async {
    final response = await restClient.get(
      APIType.protected,
      API.user + userId,
    );
    return response;
  }

  @override
  Future<Response> updateMyProfile({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.patch(
      APIType.protected,
      API.updateProfile,
      requestBody,
    );

    return response;
  }
}
