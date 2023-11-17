part of '../pages/sign_in_page.dart';

class _SignUpNavigationBuilder extends StatefulWidget {
  const _SignUpNavigationBuilder();

  @override
  State<_SignUpNavigationBuilder> createState() =>
      _SignUpNavigationBuilderState();
}

class _SignUpNavigationBuilderState extends State<_SignUpNavigationBuilder> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${TextConstants.doNotHaveAccount}  ',
          style: context.theme.text.semiBold14Circular
              .copyWith(color: context.theme.color.pineGreen),
        ),
        GestureDetector(
          onTap: _navigateToSignUpPage,
          child: Text(
            TextConstants.signUp,
            style: context.theme.text.semiBold14Circular
                .copyWith(color: context.theme.color.pineGreen),
          ),
        ),
      ],
    );
  }

  void _navigateToSignUpPage() {
    Navigator.pushNamed(
      context,
      Routes.signUp,
    );
  }
}
