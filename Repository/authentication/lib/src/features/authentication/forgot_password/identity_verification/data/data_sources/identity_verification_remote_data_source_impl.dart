part of 'identity_verification_remote_data_source.dart';

class IdentityVerificationRemoteDataSourceImp
    implements IdentityVerificationRemoteDataSource {
  const IdentityVerificationRemoteDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> identityVerification({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      APIType.public,
      API.verifyOtp,
      requestBody,
    );

    return response;
  }
}
