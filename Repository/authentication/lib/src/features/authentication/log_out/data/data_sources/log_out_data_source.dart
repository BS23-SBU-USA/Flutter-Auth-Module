// ignore_for_file: one_member_abstracts

part of 'log_out_data_source_impl.dart';

final logOutDataSourceProvider = Provider<LogOutDataSource>(
  (ref) {
    return LogOutDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class LogOutDataSource {
  Future<Response> logOut();
}
