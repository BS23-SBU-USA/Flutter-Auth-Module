import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../riverpod/sign_in_notifiers.dart';

final signInProvider =
    NotifierProvider<SignInNotifier, BaseState>(SignInNotifier.new);

final rememberMeStateProvider = StateProvider<bool>(
  (ref) => false,
  name: 'rememberMeStateProvider',
);

final offlineStateProvider = StateProvider<bool>(
  (ref) => false,
  name: 'offlineStateProvider',
);

final isUserLoggedInProvider = StateProvider<bool>(
  (ref) => false,
  name: 'navigateToHomePageProvider',
);

final buttonStateProvider = StateProvider<bool>(
  (ref) =>
      ref.read(signInProvider.notifier).emailController.text.isEmpty ||
      ref.read(signInProvider.notifier).passwordController.text.isEmpty,
);
