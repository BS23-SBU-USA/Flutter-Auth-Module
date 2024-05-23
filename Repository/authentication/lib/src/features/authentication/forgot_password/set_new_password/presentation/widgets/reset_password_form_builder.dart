part of '../pages/set_new_password_page.dart';

class _ResetPasswordFormBuilder extends ConsumerWidget {
  const _ResetPasswordFormBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(setNewPasswordFormKeyStateProvider.notifier).state,
      child: Column(
        children: [
          CustomInputField(
            onChanged: (value) {
              ref
                  .watch(passwordValidityProvider.notifier)
                  .updateValidationVariables(value);
            },
            textEditingController:
                ref.read(setNewPasswordStateProvider.notifier).state,
            labelText: TextConstants.password,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            bottomMargin: 0,
          ),
          // if (ref.watch(passwordValidityProvider).isValid)
          //   Container(height: 20.h)
          // else
          //   const PasswordValidationBuilder(),
          CustomInputField(
            textEditingController:
                ref.read(setConfirmPasswordStateProvider.notifier).state,
            labelText: TextConstants.confirmPassword,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: (value) {
              return InputValidators.confirmPassword(
                value,
                ref.read(setConfirmPasswordStateProvider.notifier).state.text,
              );
            },
          ),
        ],
      ),
    );
  }
}
