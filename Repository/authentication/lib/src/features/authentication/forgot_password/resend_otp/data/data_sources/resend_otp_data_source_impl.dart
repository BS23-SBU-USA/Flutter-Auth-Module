part of 'resend_otp_data_source.dart';

class ResendOtpDataSourceImp implements ResendOtpDataSource {
  const ResendOtpDataSourceImp({required this.restClient});

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
