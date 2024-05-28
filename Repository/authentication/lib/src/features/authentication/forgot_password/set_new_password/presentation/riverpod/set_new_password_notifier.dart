// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/riverpod/forgot_password_provider.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/presentation/riverpod/set_new_password_provider.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/use_case/set_new_password_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'set_new_password_state.dart';

final setNewPasswordProvider =
    AutoDisposeNotifierProvider<SetNewPasswordNotifier, SetNewPasswordState>(
  SetNewPasswordNotifier.new,
  name: 'setNewPasswordProvider',
);

class SetNewPasswordNotifier extends AutoDisposeNotifier<SetNewPasswordState> {
  late SetNewPasswordUseCase useCase;

  @override
  SetNewPasswordState build() {
    useCase = ref.read(setNewPasswordUseCaseProvider);
    return const SetNewPasswordState();
  }

  Future<void> newPasswordSubmit({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    state = state.copyWith(status: SetNewPasswordStatus.loading);

    final requestBody = <String, dynamic>{
      'email': email,
      'password': newPassword,
      'confirmPassword': confirmPassword,
    };

    final response = await useCase.call(
      requestBody: requestBody,
      offlineState: ref.read(offlineStateProvider),
    );

    if (response.$1.isEmpty) {
      state = state.copyWith(
        status: SetNewPasswordStatus.success,
        newPassword: state.newPassword,
        confirmPassword: state.confirmPassword,
      );
    } else {
      state = state.copyWith(
        status: SetNewPasswordStatus.failure,
        newPassword: state.newPassword,
        confirmPassword: state.confirmPassword,
        errorMessage: response.$1,
      );
    }
  }
}
