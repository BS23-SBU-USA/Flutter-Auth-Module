part of 'resend_otp_remote_data_source.dart';

class ResendOtpRemoteDataSourceImp implements ResendOtpRemoteDataSource {
  const ResendOtpRemoteDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> resendOtp({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await restClient.post(
      APIType.public,
      API.resendOtp,
      requestBody,
    );

    return response;
  }
}
