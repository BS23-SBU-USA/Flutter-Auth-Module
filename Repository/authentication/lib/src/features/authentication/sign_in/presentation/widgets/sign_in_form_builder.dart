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
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
            style: context.theme.text.regular16Caros,
            keyboardType: TextInputType.emailAddress,
            validator: InputValidators.email,
            autocorrect: false,
            borderType: BorderType.bottom,
            borderColor: UIColors.timberWolf,
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
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
            style: context.theme.text.regular16Caros,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: InputValidators.password,
            autocorrect: false,
            borderType: BorderType.bottom,
            borderColor: UIColors.timberWolf,
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
