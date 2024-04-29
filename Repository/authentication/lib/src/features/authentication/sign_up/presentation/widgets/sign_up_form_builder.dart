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
      key: ref.read(signUpFormKeyStateProvider.notifier).state,
      child: Column(
        children: [
          CustomInputField(
            textEditingController:
                ref.read(signUpFirstNameStateProvider.notifier).state,
            labelText: TextConstants.firstName,
            keyboardType: TextInputType.name,
            bottomMargin: 30.h,
            validator: InputValidators.name,
            onChanged: (value) {
              notifier.capitalizeFirstLetter(
                  ref.read(signUpFirstNameStateProvider.notifier).state);
            },
          ),
          // InputFormField(
          //   onChanged: (value) {
          //     notifier.capitalizeFirstLetter(
          //         ref.read(signUpFirstNameStateProvider.notifier).state);
          //   },
          //   textEditingController:
          //       ref.read(signUpFirstNameStateProvider.notifier).state,
          //   labelText: TextConstants.firstName,
          //   autocorrect: false,
          //   keyboardType: TextInputType.name,
          //   validator: InputValidators.name,
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   style: AppTypography.regular16Caros(),
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   bottomMargin: 30.h,
          // ),
          CustomInputField(
            textEditingController:
                ref.read(signUpSecondNameStateProvider.notifier).state,
            labelText: TextConstants.lastName,
            keyboardType: TextInputType.name,
            validator: InputValidators.name,
            bottomMargin: 30.h,
            onChanged: (value) {
              notifier.capitalizeFirstLetter(
                  ref.read(signUpSecondNameStateProvider.notifier).state);
            },
          ),
          // InputFormField(
          //   onChanged: (value) {
          //     notifier.capitalizeFirstLetter(
          //         ref.read(signUpSecondNameStateProvider.notifier).state);
          //   },
          //   textEditingController:
          //       ref.read(signUpSecondNameStateProvider.notifier).state,
          //   labelText: TextConstants.lastName,
          //   autocorrect: false,
          //   keyboardType: TextInputType.name,
          //   validator: InputValidators.name,
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   style: AppTypography.regular16Caros(),
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   bottomMargin: 30.h,
          // ),
          CustomInputField(
            textEditingController:
                ref.read(signUpEmailStateProvider.notifier).state,
            labelText: TextConstants.email,
            keyboardType: TextInputType.emailAddress,
            validator: InputValidators.email,
            bottomMargin: 30.h,
          ),
          // InputFormField(
          //   textEditingController:
          //       ref.read(signUpEmailStateProvider.notifier).state,
          //   labelText: TextConstants.email,
          //   autocorrect: false,
          //   keyboardType: TextInputType.emailAddress,
          //   validator: InputValidators.email,
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   style: AppTypography.regular16Caros(),
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   bottomMargin: 30.h,
          // ),
          CustomInputField(
            textEditingController:
                ref.read(signUpPasswordStateProvider.notifier).state,
            labelText: TextConstants.password,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            onChanged: (value) {
              ref
                  .read(passwordValidityProvider.notifier)
                  .updateValidationVariables(value);
            },
          ),
          // InputFormField(
          //   onChanged: (value) {
          //     ref
          //         .watch(passwordValidityProvider.notifier)
          //         .updateValidationVariables(value);
          //   },
          //   textEditingController:
          //       ref.read(signUpPasswordStateProvider.notifier).state,
          //   labelText: TextConstants.password,
          //   keyboardType: TextInputType.visiblePassword,
          //   password: EnabledPassword(),
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   style: AppTypography.regular16Caros(),
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   bottomMargin: 0,
          // ),
          if (ref.watch(passwordValidityProvider).isValid)
            Container(height: 20.h)
          else
            const PasswordValidationBuilder(),
          CustomInputField(
            textEditingController:
                ref.read(signUpConfirmPasswordStateProvider.notifier).state,
            labelText: TextConstants.confirmPassword,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: (value) {
              return InputValidators.confirmPassword(
                value,
                ref.read(signUpPasswordStateProvider.notifier).state.text,
              );
            },
            onChanged: (value) {
              ref
                  .watch(passwordValidityProvider.notifier)
                  .updateValidationVariables(value);
            },
          ),
          // InputFormField(
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
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   style: AppTypography.regular16Caros(),
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   bottomMargin: 0,
          // ),
        ],
      ),
    );
  }
}
