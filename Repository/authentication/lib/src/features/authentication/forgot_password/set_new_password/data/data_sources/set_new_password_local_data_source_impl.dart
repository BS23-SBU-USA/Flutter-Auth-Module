part of 'set_new_password_local_data_source.dart';

class SetNewPasswordLocalDataSourceImp
    implements SetNewPasswordLocalDataSource {
  const SetNewPasswordLocalDataSourceImp();

  @override
  Future<Response> setNewPassword(
      {required Map<String, dynamic> requestBody}) async {
    final SetNewPasswordEntity entity = SetNewPasswordEntity(
      message: 'Password updated successfully.',
    );

    return Response(
      statusCode: 200,
      requestOptions: RequestOptions(),
      statusMessage: '',
      data: entity.toJson(),
    );
  }
}
