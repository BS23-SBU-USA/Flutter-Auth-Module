import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/riverpod/identity_verification_providers.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/domain/use_case/identity_verification_use_cases.dart';
import 'package:auth_module/src/features/authentication/forgot_password/resend_otp/domain/use_case/resend_otp_use_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'identity_verification_state.dart';

final identityVerificationProvider =
    NotifierProvider<IdentityVerificationNotifier, IdentityVerificationState>(
  IdentityVerificationNotifier.new,
  name: 'identityVerificationProvider',
);

class IdentityVerificationNotifier extends Notifier<IdentityVerificationState> {
  final formKey = GlobalKey<FormState>();

  late IdentityVerificationUseCase identityVerificationUseCase;
  late ResendOtpUseCase resendOtpUseCase;

  @override
  IdentityVerificationState build() {
    identityVerificationUseCase = ref.read(identityVerificationUseCaseProvider);
    resendOtpUseCase = ref.read(resendOtpUseCaseProvider);

    return const IdentityVerificationState();
  }


  Future<void> identityVerificationSubmit({
    required String email,
    required String otp,
  }) async {
    state = state.copyWith(status: IdentityVerificationStatus.loading);
    try {
      final requestBody = <String, dynamic>{
        'email': email,
        'otp': otp,
      };

      final response = await identityVerificationUseCase.call(
        requestBody: requestBody,
        offlineState: ref.read(offlineStateProvider),
      );

      if (response.$1.isEmpty) {
        state = state.copyWith(
          status: IdentityVerificationStatus.success,
        );
      } else {
        state = state.copyWith(
          status: IdentityVerificationStatus.failure,
          errorMessage: response.$1,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: IdentityVerificationStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> resendOTPToEmail() async {
    ref.read(otpStateProvider.notifier).state.clear();

    state = state.copyWith(
      status: IdentityVerificationStatus.initial,
      otp: '',
    );
    final requestBody = <String, dynamic>{
      'email': state.email,
    };
    final response = await resendOtpUseCase.call(
      requestBody: requestBody,
      offlineState: ref.read(offlineStateProvider),
    );

    if (response.$1.isEmpty) {
      state = state.copyWith(
        status: IdentityVerificationStatus.initial,
      );
    } else {
      state = state.copyWith(
        status: IdentityVerificationStatus.failure,
        errorMessage: response.$1,
      );
    }
  }
}
