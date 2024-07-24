import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordValidityNotifier extends StateNotifier<PasswordValidationState> {
  PasswordValidityNotifier() : super(const PasswordValidationState());

  updateValidationVariables(String value) {
    final isLengthValid = value.length > 7;
    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasLower = value.contains(RegExp(r'[a-z]'));
    final hasNumber = value.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacter =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    final isValid = isLengthValid &&
        hasUpper &&
        hasLower &&
        hasNumber &&
        hasSpecialCharacter;

    state = state.copyWith(
      isLengthValid: isLengthValid,
      hasUpper: hasUpper,
      hasLower: hasLower,
      hasNumber: hasNumber,
      hasSpecialCharacter: hasSpecialCharacter,
      isValid: isValid,
    );

  }
}
