part of 'set_new_password_remote_data_source.dart';

class SetNewPasswordRemoteDataSourceImp
    implements SetNewPasswordRemoteDataSource {
  const SetNewPasswordRemoteDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> setNewPassword({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      APIType.public,
      API.setNewPassword,
      requestBody,
    );

    return response;
  }
}
