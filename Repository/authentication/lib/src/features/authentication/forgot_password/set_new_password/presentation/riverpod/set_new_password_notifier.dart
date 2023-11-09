// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/domain/use_case/set_new_password_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'set_new_password_state.dart';

final setNewPasswordProvider =
    AutoDisposeNotifierProvider<SetNewPasswordNotifier, SetNewPasswordState>(
  SetNewPasswordNotifier.new,
  name: 'setNewPasswordProvider',
);

class SetNewPasswordNotifier extends AutoDisposeNotifier<SetNewPasswordState> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late SetNewPasswordUseCase useCase;

  @override
  SetNewPasswordState build() {
    useCase = ref.read(setNewPasswordUseCaseProvider);
    return const SetNewPasswordState();
  }

  Future<void> newPasswordSubmit(String email, bool offlineState) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (offlineState) {
      offlineNewPasswordSubmit();
      return;
    }

    state = state.copyWith(status: SetNewPasswordStatus.loading);

    final requestBody = <String, dynamic>{
      'email': email,
      'password': newPasswordController.text,
      'confirmPassword': confirmPasswordController.text,
    };

    final response = await useCase.call(requestBody: requestBody);

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

  void offlineNewPasswordSubmit() {
    final password = newPasswordController.text;

    useCase.offlineNewPassword(
      password: password,
    );

    state = state.copyWith(
      status: SetNewPasswordStatus.success,
    );
  }
}
