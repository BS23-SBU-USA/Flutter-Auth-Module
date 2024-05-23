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
          builder: (context, ref, child) => ref.watch(passwordValidityProvider).isValid
              ? const SizedBox()
              : PasswordValidationBuilder(
                  passwordController,
                ),
        ),
        PasswordField.confirm(
          controller: confirmPasswordController,
          passwordController: passwordController,
        ),
        const SizedBox(height: 20),
        // CustomInputField(
        //   textEditingController:
        //       ref.read(signUpFirstNameStateProvider.notifier).state,
        //   labelText: TextConstants.firstName,
        //   keyboardType: TextInputType.name,
        //   bottomMargin: 30.h,
        //   validator: InputValidators.name,
        //   onChanged: (value) {
        //     notifier.capitalizeFirstLetter(
        //         ref.read(signUpFirstNameStateProvider.notifier).state);
        //   },
        // ),
        // CustomInputField(
        //   textEditingController:
        //       ref.read(signUpSecondNameStateProvider.notifier).state,
        //   labelText: TextConstants.lastName,
        //   keyboardType: TextInputType.name,
        //   validator: InputValidators.name,
        //   bottomMargin: 30.h,
        //   onChanged: (value) {
        //     notifier.capitalizeFirstLetter(
        //         ref.read(signUpSecondNameStateProvider.notifier).state);
        //   },
        // ),
        // CustomInputField(
        //   textEditingController:
        //       ref.read(signUpEmailStateProvider.notifier).state,
        //   labelText: TextConstants.email,
        //   keyboardType: TextInputType.emailAddress,
        //   validator: InputValidators.email,
        //   bottomMargin: 30.h,
        // ),
        // CustomInputField(
        //   textEditingController:
        //       ref.read(signUpPasswordStateProvider.notifier).state,
        //   labelText: TextConstants.password,
        //   keyboardType: TextInputType.visiblePassword,
        //   password: EnabledPassword(),
        //   onChanged: (value) {
        //     ref
        //         .read(passwordValidityProvider.notifier)
        //         .updateValidationVariables(value);
        //   },
        // ),
        // if (ref.watch(passwordValidityProvider).isValid)
        //   Container(height: 20.h)
        // else
        //   const PasswordValidationBuilder(),
        // CustomInputField(
        //   textEditingController:
        //       ref.read(signUpConfirmPasswordStateProvider.notifier).state,
        //   labelText: TextConstants.confirmPassword,
        //   keyboardType: TextInputType.visiblePassword,
        //   password: EnabledPassword(),
        //   validator: (value) {
        //     return InputValidators.confirmPassword(
        //       value,
        //       ref.read(signUpPasswordStateProvider.notifier).state.text,
        //     );
        //   },
        //   onChanged: (value) {
        //     ref
        //         .watch(passwordValidityProvider.notifier)
        //         .updateValidationVariables(value);
        //   },
        // ),
      ],
    );
  }
}
