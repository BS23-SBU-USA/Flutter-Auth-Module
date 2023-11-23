import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'log_out_data_source.dart';

class LogOutDataSourceImp implements LogOutDataSource {
  const LogOutDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> logOut() async {
    final response = restClient.post(
      API.logOut,
      apiType: APIType.protected,
      data: {},
    );

    return response;
  }
}
