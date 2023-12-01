part of 'resend_otp_local_data_source.dart';

class ResendOtpLocalDataSourceImp implements ResendOtpLocalDataSource {
  const ResendOtpLocalDataSourceImp();

  @override
  Future<Response> resendOtp(
      {required Map<String, dynamic> requestBody}) async {
    final ResendOtpEntity entity = ResendOtpEntity(
      message: 'OTP sent to your email.',
    );

    return Response(
      statusCode: 200,
      requestOptions: RequestOptions(),
      statusMessage: '',
      data: entity.toJson(),
    );
  }
}
