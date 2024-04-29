part of '../pages/sign_in_page.dart';

class _SignInFormBuilder extends ConsumerWidget {
  const _SignInFormBuilder({
    required this.emailController,
    required this.passwordController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  // GlobalKey for the form
  final GlobalKey<FormState> _formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            textEditingController: emailController,
            labelText: TextConstants.yourEmail,
            bottomMargin: 30.h,
            validator: InputValidators.email,

            // onChanged: (value) {
            //   final emailNotEmpty = value.isNotEmpty;
            //   final passwordNotEmpty = ref
            //       .read(signInPasswordStateProvider.notifier)
            //       .state
            //       .text
            //       .isNotEmpty;

            //   ref.read(buttonStateProvider.notifier).state =
            //       emailNotEmpty && passwordNotEmpty;
            // },
          ),
          CustomInputField(
            textEditingController: passwordController,
            labelText: TextConstants.password,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: InputValidators.password,

            // onChanged: (value) {
            //   final passwordNotEmpty = value.isNotEmpty;
            //   final emailNotEmpty = ref
            //       .read(signInEmailStateProvider.notifier)
            //       .state
            //       .text
            //       .isNotEmpty;
            //   ref.read(buttonStateProvider.notifier).state =
            //       emailNotEmpty && passwordNotEmpty;
            // },
          ),
          // InputFormField(
          //   textEditingController:
          //       ref.read(signInEmailStateProvider.notifier).state,
          //   labelText: TextConstants.yourEmail,
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   style: AppTypography.regular16Caros(),
          //   keyboardType: TextInputType.emailAddress,
          //   validator: InputValidators.email,
          //   autocorrect: false,
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   bottomMargin: 30.h,
          //   onChanged: (value) {
          //     final emailNotEmpty = value.isNotEmpty;
          //     final passwordNotEmpty = ref
          //         .read(signInPasswordStateProvider.notifier)
          //         .state
          //         .text
          //         .isNotEmpty;

          //     ref.read(buttonStateProvider.notifier).state =
          //         emailNotEmpty && passwordNotEmpty;
          //   },
          // ),
          // InputFormField(
          //   textEditingController:
          //       ref.read(signInPasswordStateProvider.notifier).state,
          //   bottomMargin: 0,
          //   labelText: TextConstants.password,
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   style: AppTypography.regular16Caros(),
          //   keyboardType: TextInputType.visiblePassword,
          //   password: EnabledPassword(),
          //   validator: InputValidators.password,
          //   autocorrect: false,
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   onChanged: (value) {
          //     final passwordNotEmpty = value.isNotEmpty;
          //     final emailNotEmpty = ref
          //         .read(signInEmailStateProvider.notifier)
          //         .state
          //         .text
          //         .isNotEmpty;
          //     ref.read(buttonStateProvider.notifier).state =
          //         emailNotEmpty && passwordNotEmpty;
          //   },
          // ),
        ],
      ),
    );
  }
}
