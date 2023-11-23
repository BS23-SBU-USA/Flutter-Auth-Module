part of 'identity_verification_data_source.dart';

class IdentityVerificationDataSourceImp
    implements IdentityVerificationDataSource {
  const IdentityVerificationDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> identityVerification({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      API.verifyOtp,
      data: requestBody,
    );

    return response;
  }
}
