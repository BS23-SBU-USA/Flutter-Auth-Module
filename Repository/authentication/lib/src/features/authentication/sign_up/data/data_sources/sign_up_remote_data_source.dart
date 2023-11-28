import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'sign_up_remote_data_source_impl.dart';

final signUpRemoteDataSourceProvider = Provider<SignUpRemoteDataSource>(
  (ref) {
    return SignUpRemoteDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class SignUpRemoteDataSource {
  Future<Response> signUp({required Map<String, dynamic> requestBody});
}
