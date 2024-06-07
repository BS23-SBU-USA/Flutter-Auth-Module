import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordValidationBuilder extends ConsumerWidget {
  const PasswordValidationBuilder({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {

   final  state = ref.watch(passwordValidityProvider);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          text: TextConstants.passwordMustBe,
          children: [
            _buildValidationTextSpan(
              state.isLengthValid,
              TextConstants.eightCharacter,
            ),
            const TextSpan(text: TextConstants.lengthCombination),
            _buildValidationTextSpan(
              state.hasUpper,
              TextConstants.uppercase,
            ),
            const TextSpan(text: TextConstants.letter),
            _buildValidationTextSpan(
              state.hasLower,
              TextConstants.lowercase,
            ),
            const TextSpan(text: TextConstants.letter),
            _buildValidationTextSpan(
              state.hasNumber,
              TextConstants.number,
            ),
            const TextSpan(text: TextConstants.and),
            _buildValidationTextSpan(
              state.hasSpecialCharacter,
              TextConstants.specialCharacter,
            ),
            const TextSpan(text: TextConstants.dot),
          ],
        ),
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.start,
      ),
    );
  }

  TextSpan _buildValidationTextSpan(bool isValid, String text) {
    
    return TextSpan(
      text: text,
      style: AppTypography.bold12Caros(
        color: isValid ? UIColors.pineGreen : UIColors.red,
      ),
    );
  }

  
}
