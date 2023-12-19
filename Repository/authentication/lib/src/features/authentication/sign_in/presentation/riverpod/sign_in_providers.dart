import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/entities/sign_in_entity.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      ref.read(signInEmailStateProvider.notifier).state.text.isEmpty ||
      ref.read(signInPasswordStateProvider.notifier).state.text.isEmpty,
  name: 'buttonStateProvider',
);

final signInEmailStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'signInEmailStateProvider',
);

final signInPasswordStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'signInPasswordStateProvider',
);

final signInFormKeyStateProvider = StateProvider<GlobalKey<FormState>>(
  (ref) => GlobalKey<FormState>(),
  name: 'signInFormKeyStateProvider',
);

final ssoSignInProvider = StateProvider<bool>(
  (ref) => false,
  name: 'ssoSignInProvider',
);

final ssoUserProvider = StateProvider<GoogleSignInAccount?>((ref) {
  final user = GoogleSignIn().currentUser;
  return user;
}, name: 'ssoUserProvider');
