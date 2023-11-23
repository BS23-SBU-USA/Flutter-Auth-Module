part of 'sign_in_data_source.dart';

class SignInDataSourceImp implements SignInDataSource {
  const SignInDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> signIn({required Map<String, dynamic> requestBody}) async {
    final response = await restClient.post(
      API.signIn,
      data: requestBody,
    );

    return response;
  }
}
