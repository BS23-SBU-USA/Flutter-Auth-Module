part of '../pages/sign_in_page.dart';

class _SignInFormBuilder extends ConsumerWidget {
  const _SignInFormBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(signInProvider.notifier);

    return Form(
      key: notifier.formKey,
      child: Column(
        children: [
          InputFormField(
            textEditingController: notifier.emailController,
            labelText: TextConstants.yourEmail,
            labelTextStyle: AppTypography.bold14(
              color: UIColors.secondary,
            ),
            style: AppTypography.regular16(),
            keyboardType: TextInputType.emailAddress,
            validator: InputValidators.email,
            autocorrect: false,
            borderType: BorderType.bottom,
            bottomMargin: 30.h,
            onChanged: (value) {
              final emailNotEmpty = value.isNotEmpty;
              final passwordNotEmpty = ref
                  .read(signInProvider.notifier)
                  .passwordController
                  .text
                  .isNotEmpty;

              ref.read(buttonStateProvider.notifier).state =
                  emailNotEmpty && passwordNotEmpty;
            },
          ),
          InputFormField(
            textEditingController: notifier.passwordController,
            bottomMargin: 0,
            labelText: TextConstants.password,
            labelTextStyle: AppTypography.bold14(
              color: UIColors.secondary,
            ),
            style: AppTypography.regular16(),
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: InputValidators.password,
            autocorrect: false,
            borderType: BorderType.bottom,
            onChanged: (value) {
              final emailNotEmpty = value.isNotEmpty;
              final passwordNotEmpty = ref
                  .read(signInProvider.notifier)
                  .emailController
                  .text
                  .isNotEmpty;
              ref.read(buttonStateProvider.notifier).state =
                  emailNotEmpty && passwordNotEmpty;
            },
          ),
        ],
      ),
    );
  }
}
