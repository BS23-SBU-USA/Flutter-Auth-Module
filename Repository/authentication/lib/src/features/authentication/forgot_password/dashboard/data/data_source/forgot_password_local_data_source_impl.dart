part of 'forgot_password_local_data_source.dart';

class ForgotPasswordLocalDataSourceImp
    implements ForgotPasswordLocalDataSource {
  const ForgotPasswordLocalDataSourceImp({required this.mockUser});

  final MockUserModel mockUser;

  @override
  Future<Response> forgotPassword(
      {required Map<String, dynamic> requestBody}) async {
    final bool isValidCredentials = requestBody['email'] == mockUser.email;

    final ForgotPasswordEntity entity = isValidCredentials
        ? ForgotPasswordEntity(
            message: 'OTP sent to your email.',
          )
        : ForgotPasswordEntity(
            message: 'Invalid Email!',
          );

    return Response(
      statusCode: isValidCredentials ? 200 : 404,
      requestOptions: RequestOptions(),
      statusMessage: isValidCredentials ? '' : 'Invalid Email!',
      data: entity.toJson(),
    );
  }
}
