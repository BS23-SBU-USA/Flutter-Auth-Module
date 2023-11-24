part of 'sign_up_remote_data_source.dart';

class SignUpRemoteDataSourceImp implements SignUpRemoteDataSource {
  const SignUpRemoteDataSourceImp({required this.restClient});

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
