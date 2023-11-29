part of 'change_password_remote_data_source.dart';

class ChangePasswordRemoteDataSourceImp
    implements ChangePasswordRemoteDataSource {
  const ChangePasswordRemoteDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> changePassword({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      APIType.protected,
      API.changePassword,
      requestBody,
    );

    return response;
  }
}
