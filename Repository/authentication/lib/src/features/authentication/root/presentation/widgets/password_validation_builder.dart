import 'package:auth_module/src/core/theme/extension.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
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
              context,
              state.isLengthValid,
              TextConstants.eightCharacter,
            ),
            const TextSpan(text: TextConstants.lengthCombination),
            _buildValidationTextSpan(
              context,
              state.hasUpper,
              TextConstants.uppercase,
            ),
            const TextSpan(text: TextConstants.letter),
            _buildValidationTextSpan(
              context,
              state.hasLower,
              TextConstants.lowercase,
            ),
            const TextSpan(text: TextConstants.letter),
            _buildValidationTextSpan(
              context,
              state.hasNumber,
              TextConstants.number,
            ),
            const TextSpan(text: TextConstants.and),
            _buildValidationTextSpan(
              context,
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

  TextSpan _buildValidationTextSpan(BuildContext context, bool isValid, String text) {
    
    return TextSpan(
      text: text,
      style: AppTypography.bold12Caros(
        color: isValid ? context.color.primary : context.color.error,
      ),
    );
  }

  
}
