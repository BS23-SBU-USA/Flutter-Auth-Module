part of 'sign_in_data_source.dart';

class SignInRemoteDataSourceImp implements SignInRemoteDataSource {
  const SignInRemoteDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> signIn({required Map<String, dynamic> requestBody}) async {
    final response = await restClient.post(
      APIType.public,
      API.signIn,
      requestBody,
    );

    return response;
  }
}

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
            message: 'User not found!',
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
      statusMessage: isValidCredentials ? '' : 'User not found!',
      data: entity.toJson(),
    );
  }
}
