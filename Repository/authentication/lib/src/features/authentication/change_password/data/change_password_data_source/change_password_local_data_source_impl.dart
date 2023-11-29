part of 'change_password_local_data_source.dart';

class ChangePasswordLocalDataSourceImp
    implements ChangePasswordLocalDataSource {
  const ChangePasswordLocalDataSourceImp();

  @override
  Future<Response> changePassword(
      {required Map<String, dynamic> requestBody}) async {
    final ChangePasswordEntity entity = ChangePasswordEntity(
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
