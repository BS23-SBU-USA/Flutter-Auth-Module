part of 'sign_in_remote_data_source.dart';

class SignInRemoteDataSourceImp implements SignInRemoteDataSource {
  const SignInRemoteDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> signIn({required Map<String, dynamic> requestBody}) async {
    final response = await restClient.post(
      APIType.public,
      API.signIn,
      requestBody,
    );

    return response;
  }
}
