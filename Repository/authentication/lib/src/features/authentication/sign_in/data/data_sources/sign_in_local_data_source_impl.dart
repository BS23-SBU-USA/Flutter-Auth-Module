part of 'sign_in_local_data_source.dart';

class SignInLocalDataSourceImp implements SignInLocalDataSource {
  const SignInLocalDataSourceImp({required this.mockUser});

  final MockUserModel mockUser;

  @override
  Future<Response> signIn({required Map<String, dynamic> requestBody}) async {
    final bool isValidCredentials = requestBody['email'] == mockUser.email &&
        requestBody['password'] == mockUser.password;

    final SignInEntity entity = isValidCredentials
        ? SignInEntity(
            message: 'Success',
            token: 'Token',
            user: UserModel(
              id: mockUser.id,
              email: mockUser.email,
              role: mockUser.role,
              password: mockUser.password,
              firstName: mockUser.firstName,
              lastName: mockUser.lastName,
            ),
          )
        : SignInEntity(
            message: 'Invalid Credentials!',
            token: '',
            user: UserModel(
              id: '',
              email: '',
              role: '',
              password: '',
              firstName: '',
              lastName: '',
            ),
          );

    return Response(
      statusCode: isValidCredentials ? 200 : 404,
      requestOptions: RequestOptions(),
      statusMessage: isValidCredentials ? '' : 'Invalid Credentials!',
      data: entity.toJson(),
    );
  }
}
