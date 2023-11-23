part of 'profile_data_source.dart';

class ProfileDataSourceImp implements ProfileDataSource {
  const ProfileDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> fetchUserProfile(String userId) async {
    final response = await restClient.get(
      API.user + userId,
      apiType: APIType.protected,
    );
    return response;
  }

  @override
  Future<Response> updateMyProfile({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.patch(
      API.updateProfile,
      apiType: APIType.protected,
      data: requestBody,
    );

    return response;
  }

  @override
  Future<Response> uploadImage({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      API.uploadImage,
      apiType: APIType.protected,
      data: requestBody,
      isFormData: true,
    );

    return response;
  }
}
