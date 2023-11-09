// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'sign_up_data_source_impl.dart';

final signUpDataSourceProvider = Provider<SignUpDataSource>(
  (ref) {
    return SignUpDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class SignUpDataSource {
  Future<Response> signUp({required Map<String, dynamic> requestBody});
}
