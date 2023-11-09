part of 'sign_up_data_source.dart';

class SignUpDataSourceImp implements SignUpDataSource {
  const SignUpDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> signUp({required Map<String, dynamic> requestBody}) async {
    final response = await restClient.post(
      APIType.public,
      API.signUp,
      requestBody,
    );

    return response;
  }
}
