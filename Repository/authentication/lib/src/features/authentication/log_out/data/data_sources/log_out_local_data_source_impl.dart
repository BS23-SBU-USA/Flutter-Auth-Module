part of 'log_out_local_data_source.dart';

class LogOutLocalDataSourceImp implements LogOutLocalDataSource {
  const LogOutLocalDataSourceImp();

  @override
  Future<Response> logOut() async {
    final LogOutEntity entity = LogOutEntity(
      message: 'Logout successfully.',
    );

    return Response(
      statusCode: 200,
      requestOptions: RequestOptions(),
      statusMessage: '',
      data: entity.toJson(),
    );
  }
}
