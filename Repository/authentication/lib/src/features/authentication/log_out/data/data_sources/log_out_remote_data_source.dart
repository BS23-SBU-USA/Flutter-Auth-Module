// ignore_for_file: one_member_abstracts

part of 'log_out_remote_data_source_impl.dart';

final logOutRemoteDataSourceProvider = Provider<LogOutRemoteDataSource>(
  (ref) {
    return LogOutRemoteDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class LogOutRemoteDataSource {
  Future<Response> logOut();
}
