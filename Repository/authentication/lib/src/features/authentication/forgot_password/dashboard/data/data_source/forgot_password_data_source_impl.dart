part of 'forgot_password_data_source.dart';

class ForgotPasswordDataSourceImp implements ForgotPasswordDataSource {
  const ForgotPasswordDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> forgotPassword({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      API.forgotPassword,
      data: requestBody,
    );

    return response;
  }
}
