part of 'set_new_password_data_source.dart';

class SetNewPasswordDataSourceImp implements SetNewPasswordDataSource {
  const SetNewPasswordDataSourceImp({required this.restClient});

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
