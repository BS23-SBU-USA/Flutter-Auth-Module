import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/utils/validators/input_validators.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordField extends ConsumerWidget {
  PasswordField({
    super.key,
    this.labelText = TextConstants.password,
    required this.controller,
  })  : passwordController = null,
        isConfirmField = false;

  PasswordField.confirm({
    super.key,
    required this.controller,
    this.labelText = TextConstants.confirmPassword,
    required this.passwordController,
  }) : isConfirmField = true;

  final bool isConfirmField;
  final String labelText;
  final TextEditingController? passwordController;
  final TextEditingController controller;
  final ValueNotifier<bool> visibility = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _updatePasswordValidity(ref);
    return ValueListenableBuilder<bool>(
      valueListenable: visibility,
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          validator: isConfirmField
              ? (value) => InputValidators.confirmPassword(
                    value,
                    passwordController!.text,
                  )
              : null,
          keyboardType: TextInputType.visiblePassword,
          obscureText: value,
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: IconButton(
              onPressed: () {
                visibility.value = !value;
              },
              icon: value
                  ? Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              splashColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }

  void _updatePasswordValidity(WidgetRef ref) {
    if (!isConfirmField) {
      controller.addListener(() {
        ref
            .read(passwordValidityProvider.notifier)
            .updateValidationVariables(controller.text);
      });
    }
  }
}
