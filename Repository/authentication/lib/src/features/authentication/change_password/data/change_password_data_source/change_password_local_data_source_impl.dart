part of 'change_password_local_data_source.dart';

class ChangePasswordLocalDataSourceImp
    implements ChangePasswordLocalDataSource {
  const ChangePasswordLocalDataSourceImp({required this.mockUser});

  final MockUserModel mockUser;

  @override
  Future<Response> changePassword(
      {required Map<String, dynamic> requestBody}) async {
    final bool isValidCredentials =
        requestBody['oldPassword'] == mockUser.password;

    final ChangePasswordEntity entity = isValidCredentials
        ? ChangePasswordEntity(
            message: 'Password updated successfully.',
          )
        : ChangePasswordEntity(
            message: 'Old Password Incorrect.',
          );

    return Response(
      statusCode: isValidCredentials ? 200 : 404,
      requestOptions: RequestOptions(),
      statusMessage: isValidCredentials ? '' : 'Old Password Incorrect.',
      data: entity.toJson(),
    );
  }
}
