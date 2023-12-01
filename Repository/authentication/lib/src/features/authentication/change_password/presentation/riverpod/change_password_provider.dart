import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/change_password/domain/use_cases/change_password_use_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'change_password_notifier.dart';

part 'change_password_state.dart';

final changePasswordProvider =
    AutoDisposeNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
  ChangePasswordNotifier.new,
);

final changedOldPasswordStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'changedOldPasswordStateProvider',
);

final changedNewPasswordStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'changedNewPasswordStateProvider',
);

final changedConfirmPasswordStateProvider =
    StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'changedConfirmPasswordStateProvider',
);

final changePasswordFormKeyStateProvider = StateProvider<GlobalKey<FormState>>(
  (ref) => GlobalKey<FormState>(),
  name: 'changePasswordFormKeyStateProvider',
);
