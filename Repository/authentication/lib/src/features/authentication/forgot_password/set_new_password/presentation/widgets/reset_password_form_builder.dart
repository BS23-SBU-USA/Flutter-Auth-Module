part of '../pages/set_new_password_page.dart';

class _ResetPasswordFormBuilder extends ConsumerWidget {
  const _ResetPasswordFormBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(setNewPasswordFormKeyStateProvider.notifier).state,
      child: Column(
        children: [
          InputFormField(
            onChanged: (value) {
              ref
                  .watch(passwordValidityProvider.notifier)
                  .updateValidationVariables(value);
            },
            textEditingController:
                ref.read(setNewPasswordStateProvider.notifier).state,
            labelText: TextConstants.password,
            borderColor: UIColors.timberWolf,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            autocorrect: false,
            bottomMargin: 0,
            borderType: BorderType.bottom,
            style: AppTypography.regular16Caros(),
            labelTextStyle: AppTypography.medium14Circular(
              color: UIColors.pineGreen,
            ),
          ),
          if (ref.watch(passwordValidityProvider).isValid)
            Container(height: 20.h)
          else
            const PasswordValidationBuilder(),
          InputFormField(
            textEditingController:
                ref.read(setConfirmPasswordStateProvider.notifier).state,
            labelText: TextConstants.confirmPassword,
            borderColor: UIColors.timberWolf,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            autocorrect: false,
            validator: (value) {
              return InputValidators.confirmPassword(
                value,
                ref.read(setConfirmPasswordStateProvider.notifier).state.text,
              );
            },
            borderType: BorderType.bottom,
            style: AppTypography.regular16Caros(),
            labelTextStyle: AppTypography.medium14Circular(
              color: UIColors.pineGreen,
            ),
          ),
        ],
      ),
    );
  }
}
