part of '../pages/sign_in_page.dart';

class _SignInFormBuilder extends ConsumerWidget {
  const _SignInFormBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOptionState = ref.read(userOptionStateProvider.notifier).state;
    return Form(
      key: ref.read(signInFormKeyStateProvider.notifier).state,
      child: Column(
        children: [
          InputFormField(
            textEditingController: userOptionState == 'email'
                ? ref.read(signInEmailStateProvider.notifier).state
                : ref.read(signInMobileStateProvider.notifier).state,
            labelText: userOptionState == 'email'
                ? TextConstants.yourEmail
                : TextConstants.phoneNumber,
            labelTextStyle: AppTypography.medium14Circular(
              color: UIColors.pineGreen,
            ),
            style: AppTypography.regular16Caros(),
            keyboardType: userOptionState == 'email'
                ? TextInputType.emailAddress
                : TextInputType.phone,
            validator: userOptionState == 'email'
                ? InputValidators.email
                : InputValidators.phone,
            maxLength: userOptionState == 'email' ? null : 10,
            prefix: userOptionState == 'email'
                ? null
                : IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountryCodePicker(
                          initialSelection: ref
                              .read(signInCountryCodeStateProvider.notifier)
                              .state
                              .text,
                          padding: EdgeInsets.zero,
                          countryFilter: const ['+880', 'US'],
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: UIColors.black,
                          ),
                          onChanged: (country) {
                            ref
                                .read(signInCountryCodeStateProvider.notifier)
                                .state
                                .text = country.dialCode!;
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: const VerticalDivider(
                            color: UIColors.black,
                            width: 1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
            autocorrect: false,
            borderType: BorderType.bottom,
            borderColor: UIColors.timberWolf,
            bottomMargin: 30.h,
            onChanged: (value) {
              final userOptionNotEmpty = value.isNotEmpty;
              final passwordNotEmpty = ref
                  .read(signInPasswordStateProvider.notifier)
                  .state
                  .text
                  .isNotEmpty;

              ref.read(buttonStateProvider.notifier).state =
                  userOptionNotEmpty && passwordNotEmpty;
            },
          ),
          InputFormField(
            textEditingController:
                ref.read(signInPasswordStateProvider.notifier).state,
            bottomMargin: 0,
            labelText: TextConstants.password,
            labelTextStyle: AppTypography.medium14Circular(
              color: UIColors.pineGreen,
            ),
            style: AppTypography.regular16Caros(),
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: InputValidators.password,
            autocorrect: false,
            borderType: BorderType.bottom,
            borderColor: UIColors.timberWolf,
            onChanged: (value) {
              final passwordNotEmpty = value.isNotEmpty;
              final emailNotEmpty = ref
                  .read(signInEmailStateProvider.notifier)
                  .state
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
