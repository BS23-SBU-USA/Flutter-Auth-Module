import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validation_state.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordValidityProvider = StateNotifierProvider.autoDispose<
    PasswordValidityNotifier, PasswordValidationState>(
  (ref) {
    return PasswordValidityNotifier();
  },
);
