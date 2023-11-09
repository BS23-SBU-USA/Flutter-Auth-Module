// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'sign_in_data_source_impl.dart';

final signInDataSourceProvider = Provider<SignInDataSource>(
  (ref) {
    return SignInDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class SignInDataSource {
  Future<Response> signIn({
    required Map<String, dynamic> requestBody,
  });
}
