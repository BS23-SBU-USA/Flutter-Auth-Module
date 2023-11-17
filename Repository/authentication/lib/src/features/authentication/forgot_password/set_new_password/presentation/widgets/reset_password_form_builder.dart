part of '../pages/set_new_password_page.dart';

class _ResetPasswordFormBuilder extends ConsumerWidget {
  const _ResetPasswordFormBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(setNewPasswordProvider.notifier);

    return Form(
      key: notifier.formKey,
      child: Column(
        children: [
          InputFormField(
            onChanged: (value) {
              ref
                  .watch(passwordValidityProvider.notifier)
                  .updateValidationVariables(value);
            },
            textEditingController: notifier.newPasswordController,
            labelText: TextConstants.password,
            borderColor: UIColors.timberWolf,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            autocorrect: false,
            bottomMargin: 0,
            borderType: BorderType.bottom,
            style: context.theme.text.regular16Caros,
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
          ),
          if (ref.watch(passwordValidityProvider).isValid)
            Container(height: 20.h)
          else
            const PasswordValidationBuilder(),
          InputFormField(
            textEditingController: notifier.confirmPasswordController,
            labelText: TextConstants.confirmPassword,
            borderColor: UIColors.timberWolf,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            autocorrect: false,
            validator: (value) {
              return InputValidators.confirmPassword(
                value,
                notifier.confirmPasswordController.text,
              );
            },
            borderType: BorderType.bottom,
            style: context.theme.text.regular16Caros,
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
          ),
        ],
      ),
    );
  }
}
