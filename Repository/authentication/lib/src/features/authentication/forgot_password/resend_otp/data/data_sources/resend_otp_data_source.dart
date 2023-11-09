// ignore_for_file: one_member_abstracts

import 'package:auth_module/src/core/services/network/api_end_points.dart';
import 'package:auth_module/src/core/services/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'resend_otp_data_source_impl.dart';

final resendOtpDataSourceProvider = Provider<ResendOtpDataSource>(
  (ref) {
    return ResendOtpDataSourceImp(
      restClient: ref.read(networkProvider),
    );
  },
);

abstract class ResendOtpDataSource {
  Future<Response> resendOtp({required Map<String, dynamic> requestBody});
}
