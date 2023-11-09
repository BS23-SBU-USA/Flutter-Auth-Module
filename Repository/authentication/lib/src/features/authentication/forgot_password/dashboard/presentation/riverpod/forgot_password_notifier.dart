import 'package:equatable/equatable.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/use_case/forgot_password_use_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'forgot_password_state.dart';

final forgotPasswordProvider =
    AutoDisposeNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  ForgotPasswordNotifier.new,
  name: 'forgotPasswordProvider',
);

class ForgotPasswordNotifier extends AutoDisposeNotifier<ForgotPasswordState> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  late ForgotPasswordUseCase useCase;

  @override
  ForgotPasswordState build() {
    useCase = ref.read(forgotPasswordUseCaseProvider);
    return const ForgotPasswordState();
  }

  Future<void> forgotPasswordSubmit(bool offlineState) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (offlineState) {
        offlineEmailSubmit();
        return;
      }

      state = state.copyWith(status: ForgotPasswordStatus.loading);

      final requestBody = <String, dynamic>{
        'email': emailController.text,
      };

      final response = await useCase.call(requestBody: requestBody);

      if (response.$1.isEmpty) {
        state = state.copyWith(
          status: ForgotPasswordStatus.success,
        );
      } else {
        state = state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: response.$1,
        );
      }
    } catch (e, stackTrace) {
      Log.debug(stackTrace.toString());
      state = state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  void offlineEmailSubmit() {
    final email = emailController.text;

    final result = useCase.offlineEmail(
      email: email,
    );

    if (result) {
      state = state.copyWith(
        status: ForgotPasswordStatus.success,
      );
    } else {
      state = state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: 'Invalid email',
      );
    }
  }
}
