// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'change_password_data_source_impl.dart';

abstract class ChangePasswordDataSource {
  Future<Response> changePassword({
    required Map<String, dynamic> requestBody,
  });
}

final changePasswordDataSourceProvider = Provider<ChangePasswordDataSource>(
  (ref) {
    return ChangePasswordDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);
