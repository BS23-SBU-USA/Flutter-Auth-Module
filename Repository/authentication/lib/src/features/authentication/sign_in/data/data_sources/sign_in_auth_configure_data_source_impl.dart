part of 'sign_in_auth_configure_data_source.dart';

class SignInAuthConfigureDataSourceImp
    implements SignInAuthConfigureDataSource {
  const SignInAuthConfigureDataSourceImp();

  @override
  Future<AuthConfigureEntity> authConfigure() async {
    try {
      final String response = await rootBundle.loadString(Assets.authConfigure);
      final Map<String, dynamic> jsonMap = json.decode(response);
      Log.debug(jsonMap.toString());

      return AuthConfigureEntity.fromJson(jsonMap);
    } catch (e) {
      Log.debug('Error reading JSON: $e');
      return AuthConfigureEntity(
        logoVisibility: false,
        ssoVisibility: true,
        userOption: 'email',
      );
    }
  }
}
