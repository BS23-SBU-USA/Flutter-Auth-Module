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
        ],
      ),
    );
  }
}
