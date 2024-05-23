import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/utils/validators/input_validators.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordField extends ConsumerWidget {
  PasswordField({
    super.key,
    required this.controller,
  })  : passwordController = null,
        isConfirmField = false;

  PasswordField.confirm({
    super.key,
    required this.controller,
    required this.passwordController,
  }) : isConfirmField = true;

  final bool isConfirmField;
  final TextEditingController? passwordController;
  final TextEditingController controller;
  final ValueNotifier<bool> visibility = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isConfirmField) {
      controller.addListener(() {
        ref
            .read(passwordValidityProvider.notifier)
            .updateValidationVariables(controller.text);
      });
    }
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
            labelText: isConfirmField
                ? TextConstants.confirmPassword
                : TextConstants.password,
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
}
