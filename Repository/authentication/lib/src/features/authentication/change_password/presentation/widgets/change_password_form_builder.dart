part of '../pages/change_password_page.dart';

class ChangePasswordFormBuilder extends StatelessWidget {
  const ChangePasswordFormBuilder({
    super.key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final TextEditingController oldPasswordController;

  final TextEditingController newPasswordController;

  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PasswordField(
            controller: oldPasswordController,
            labelText: TextConstants.oldPassword,
          ),
          PasswordField(
            controller: newPasswordController,
            labelText: TextConstants.newPassword,
          ),
          Consumer(
            builder: (context, ref, child) =>
                ref.watch(passwordValidityProvider).isValid
                    ? const SizedBox()
                    : const PasswordValidationBuilder(),
          ),
          PasswordField.confirm(
            controller: confirmPasswordController,
            passwordController: newPasswordController,
          ),
          // CustomInputField(
          //   textEditingController: oldPasswordState,
          //   labelText: TextConstants.oldPassword,
          //   keyboardType: TextInputType.visiblePassword,
          //   validator: InputValidators.password,
          //   bottomMargin: 30.h,
          //   password: EnabledPassword(),
          // ),
          // CustomInputField(
          //   onChanged: (value) {
          //     ref
          //         .read(passwordValidityProvider.notifier)
          //         .updateValidationVariables(value);
          //   },
          //   textEditingController: newPasswordState,
          //   labelText: TextConstants.newPassword,
          //   keyboardType: TextInputType.visiblePassword,
          //   password: EnabledPassword(),
          //   bottomMargin: 0,
          // ),
          // // if (ref.watch(passwordValidityProvider).isValid)
          // //   Container(height: 20.h)
          // // else
          // //   const PasswordValidationBuilder(),
          // CustomInputField(
          //   textEditingController: confirmPasswordState,
          //   labelText: TextConstants.confirmPassword,
          //   keyboardType: TextInputType.visiblePassword,
          //   password: EnabledPassword(),
          //   validator: (value) {
          //     return InputValidators.confirmPassword(
          //       value,
          //       newPasswordState.text,
          //     );
          //   },
          //   bottomMargin: 30.h,
          // ),
        ],
      ),
    );
  }
}
