part of '../pages/sign_up_page.dart';

class SignUpFormBuilder extends ConsumerStatefulWidget {
  const SignUpFormBuilder({super.key});

  @override
  ConsumerState<SignUpFormBuilder> createState() => _SignUpFormBuilderState();
}

class _SignUpFormBuilderState extends ConsumerState<SignUpFormBuilder> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signUpProvider.notifier);

    return Form(
      key: notifier.formKey,
      child: Column(
        children: [
          InputFormField(
            onChanged: (value) {
              notifier.capitalizeFirstLetter(notifier.firstNameController);
            },
            textEditingController: notifier.firstNameController,
            labelText: TextConstants.firstName,
            autocorrect: false,
            keyboardType: TextInputType.name,
            validator: InputValidators.name,
            borderType: BorderType.bottom,
            borderColor: context.theme.color.timberWolf,
            style: context.theme.text.regular16Caros,
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
            bottomMargin: 30.h,
          ),
          InputFormField(
            onChanged: (value) {
              notifier.capitalizeFirstLetter(notifier.secondNameController);
            },
            textEditingController: notifier.secondNameController,
            labelText: TextConstants.lastName,
            autocorrect: false,
            keyboardType: TextInputType.name,
            validator: InputValidators.name,
            borderType: BorderType.bottom,
            borderColor: context.theme.color.timberWolf,
            style: context.theme.text.regular16Caros,
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
            bottomMargin: 30.h,
          ),
          InputFormField(
            textEditingController: notifier.emailController,
            labelText: TextConstants.email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            validator: InputValidators.email,
            borderType: BorderType.bottom,
            borderColor: context.theme.color.timberWolf,
            style: context.theme.text.regular16Caros,
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
            bottomMargin: 30.h,
          ),
          InputFormField(
            onChanged: (value) {
              ref
                  .watch(passwordValidityProvider.notifier)
                  .updateValidationVariables(value);
            },
            textEditingController: notifier.passwordController,
            labelText: TextConstants.password,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            borderType: BorderType.bottom,
            borderColor: context.theme.color.timberWolf,
            style: context.theme.text.regular16Caros,
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
            bottomMargin: 0,
          ),
          if (ref.watch(passwordValidityProvider).isValid)
            Container(height: 20.h)
          else
            const PasswordValidationBuilder(),
          InputFormField(
            textEditingController: notifier.confirmPasswordController,
            labelText: TextConstants.confirmPassword,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: (value) {
              return InputValidators.confirmPassword(
                value,
                notifier.passwordController.text,
              );
            },
            borderType: BorderType.bottom,
            borderColor: context.theme.color.timberWolf,
            style: context.theme.text.regular16Caros,
            labelTextStyle: context.theme.text.medium14Circular
                .copyWith(color: context.theme.color.pineGreen),
            bottomMargin: 0,
          ),
        ],
      ),
    );
  }
}
