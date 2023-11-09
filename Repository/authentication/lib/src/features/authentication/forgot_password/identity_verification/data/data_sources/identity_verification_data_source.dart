// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'identity_verification_data_source_impl.dart';

final identityVerificationDataSourceProvider =
    Provider<IdentityVerificationDataSource>(
  (ref) {
    return IdentityVerificationDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class IdentityVerificationDataSource {
  Future<Response> identityVerification({
    required Map<String, dynamic> requestBody,
  });
}
