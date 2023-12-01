part of 'sign_up_local_data_source.dart';

class SignUpLocalDataSourceImp implements SignUpLocalDataSource {
  const SignUpLocalDataSourceImp();

  @override
  Future<Response> signUp({required Map<String, dynamic> requestBody}) async {
    final SignUpEntity entity = SignUpEntity(
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
