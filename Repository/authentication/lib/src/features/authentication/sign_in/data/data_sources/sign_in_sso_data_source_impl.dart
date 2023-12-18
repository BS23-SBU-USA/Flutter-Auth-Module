part of 'sign_in_sso_data_source.dart';

class SSOSignInDataSourceImp implements SSOSignInDataSource {
  const SSOSignInDataSourceImp();

  @override
  Future<Response> ssoSignIn({required BuildContext context}) async {
    Map<String, dynamic> result =
        await Authentication.signInWithGoogle(context: context);

    return Response(
      requestOptions: RequestOptions(),
      statusMessage: result['errorCode'],
      data: result['user'],
    );
  }
}
