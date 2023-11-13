import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordValidationBuilder extends ConsumerStatefulWidget {
  const PasswordValidationBuilder({super.key});

  @override
  ConsumerState<PasswordValidationBuilder> createState() =>
      _PasswordValidationBuilderState();
}

class _PasswordValidationBuilderState
    extends ConsumerState<PasswordValidationBuilder> {
  @override
  Widget build(BuildContext context) {
    final passWordValidityState = ref.watch(passwordValidityProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          text: TextConstants.passwordMustBe,
          children: [
            _buildValidationTextSpan(
              passWordValidityState.isLengthValid,
              TextConstants.eightCharacter,
            ),
            const TextSpan(text: TextConstants.lengthCombination),
            _buildValidationTextSpan(
              passWordValidityState.hasUpper,
              TextConstants.uppercase,
            ),
            const TextSpan(text: TextConstants.letter),
            _buildValidationTextSpan(
              passWordValidityState.hasLower,
              TextConstants.lowercase,
            ),
            const TextSpan(text: TextConstants.letter),
            _buildValidationTextSpan(
              passWordValidityState.hasNumber,
              TextConstants.number,
            ),
            const TextSpan(text: TextConstants.and),
            _buildValidationTextSpan(
              passWordValidityState.hasSpecialCharacter,
              TextConstants.specialCharacter,
            ),
            const TextSpan(text: TextConstants.dot),
          ],
        ),
        style: AppTypography.regular12Caros(),
        textAlign: TextAlign.start,
      ),
    );
  }

  TextSpan _buildValidationTextSpan(bool isValid, String text) {
    return TextSpan(
      text: text,
      style: AppTypography.bold12Caros(
        color: isValid ? UIColors.pineGreen : null,
      ),
    );
  }
}
