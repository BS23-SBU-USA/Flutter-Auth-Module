part of '../pages/sign_in_page.dart';

class _SignInFormBuilder extends StatelessWidget {
  const _SignInFormBuilder({
    required this.emailController,
    required this.passwordController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            validator: InputValidators.email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: TextConstants.yourEmail,
            ),
          ),
          const SizedBox(height: 20),
          PasswordField(controller: passwordController),
        ],
      ),
    );
  }
}
