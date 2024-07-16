import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'sign_in_remote_data_source_impl.dart';

final signInRemoteDataSourceProvider = Provider<SignInRemoteDataSource>(
  (ref) {
    return SignInRemoteDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class SignInRemoteDataSource {
  Future<Response> signIn({required Map<String, dynamic> requestBody});
}
