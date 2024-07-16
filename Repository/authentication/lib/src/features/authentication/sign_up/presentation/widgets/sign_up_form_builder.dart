part of '../pages/sign_up_page.dart';

class SignUpFormBuilder extends StatelessWidget {
  const SignUpFormBuilder({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: firstNameController,
          validator: InputValidators.name,
          keyboardType: TextInputType.name,
          inputFormatters: [
            FirstLetterUpperCaseTextFormatter(),
          ],
          decoration: const InputDecoration(
            labelText: TextConstants.firstName,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: lastNameController,
          inputFormatters: [
            FirstLetterUpperCaseTextFormatter(),
          ],
          validator: InputValidators.name,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: TextConstants.lastName,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: emailController,
          validator: InputValidators.email,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: TextConstants.email,
          ),
        ),
        const SizedBox(height: 20),
        PasswordField(controller: passwordController),
        Consumer(
          builder: (context, ref, child) =>
              ref.watch(passwordValidityProvider).isValid
                  ? const SizedBox()
                  : const PasswordValidationBuilder(),
        ),
        PasswordField.confirm(
          controller: confirmPasswordController,
          passwordController: passwordController,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
