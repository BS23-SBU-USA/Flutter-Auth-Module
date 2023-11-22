import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:auth_module/src/features/authentication/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../riverpod/sign_up_notifiers.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, BaseState>(
  (ref) => SignUpNotifier(
    ref.watch(signUpUseCaseProvider),
  ),
);

final signUpFormValidationProvider = StateProvider.autoDispose<bool>(
  (ref) {
    return ref.watch(passwordValidityProvider).isValid &&
        ref.watch(termsAndConditionCheckerProvider);
  },
);

final termsAndConditionCheckerProvider = StateProvider<bool>((ref) => false);
