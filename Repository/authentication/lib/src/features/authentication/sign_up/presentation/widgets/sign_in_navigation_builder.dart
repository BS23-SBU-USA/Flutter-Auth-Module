part of '../pages/sign_up_page.dart';

class _SignInNavigationBuilder extends StatefulWidget {
  const _SignInNavigationBuilder();

  @override
  State<_SignInNavigationBuilder> createState() =>
      _SignInNavigationBuilderState();
}

class _SignInNavigationBuilderState extends State<_SignInNavigationBuilder> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TextConstants.alreadyHaveAnAccount,
          style: context.theme.text.semiBold14Circular
              .copyWith(color: context.theme.color.pineGreen),
        ),
        GestureDetector(
          onTap: _navigateToSignInPage,
          child: Text(
            TextConstants.login,
            style: context.theme.text.semiBold14Circular
                .copyWith(color: context.theme.color.pineGreen),
          ),
        ),
      ],
    );
  }

  void _navigateToSignInPage() {
    Navigator.pushNamed(
      context,
      Routes.signIn,
    );
  }
}
