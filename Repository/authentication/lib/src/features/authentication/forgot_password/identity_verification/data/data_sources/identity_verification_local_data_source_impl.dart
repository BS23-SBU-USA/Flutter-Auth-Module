part of 'identity_verification_local_data_source.dart';

class IdentityVerificationLocalDataSourceImp
    implements IdentityVerificationLocalDataSource {
  const IdentityVerificationLocalDataSourceImp({required this.mockUser});

  final MockUserModel mockUser;

  @override
  Future<Response> identityVerification(
      {required Map<String, dynamic> requestBody}) async {
    final bool isValidCredentials = requestBody['otp'] == mockUser.otp;

    final IdentityVerificationEntity entity = isValidCredentials
        ? IdentityVerificationEntity(
            message: 'OTP verified successfully.',
          )
        : IdentityVerificationEntity(
            message: 'Wrong OTP!',
          );

    return Response(
      statusCode: isValidCredentials ? 200 : 404,
      requestOptions: RequestOptions(),
      statusMessage: isValidCredentials ? '' : 'Wrong OTP!',
      data: entity.toJson(),
    );
  }
}
