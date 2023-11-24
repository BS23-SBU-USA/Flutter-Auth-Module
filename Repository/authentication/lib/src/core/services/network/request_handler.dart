import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/network/error_model.dart';
import 'package:network/network.dart';

extension FutureResponseExtension on Future<Response> {
  Future<(String, T?)> guard<T>(T Function(dynamic) parse, {T? data}) async {
    try {
      final response = await this;
      return ('', data ?? parse(response.data));
    } catch (e, stacktrace) {
      Log.error(e.toString());
      Log.error(stacktrace.toString());
      final errorModel = ErrorModel.fromJson((e as Failure).error);
      return (errorModel.message, null);
    }
  }
}
