part of 'forgot_password_remote_data_source.dart';

class ForgotPasswordRemoteDataSourceImp
    implements ForgotPasswordRemoteDataSource {
  const ForgotPasswordRemoteDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> forgotPassword({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      APIType.public,
      API.forgotPassword,
      requestBody,
    );

    return response;
  }
}
