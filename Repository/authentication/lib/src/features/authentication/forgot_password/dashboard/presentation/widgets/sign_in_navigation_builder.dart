part of '../pages/forgot_password_page.dart';

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
          TextConstants.rememberYourPassword,
          style: AppTypography.semiBold14Circular(color: UIColors.pineGreen),
        ),
        GestureDetector(
          onTap: _navigateToSignInPage,
          child: Text(
            ' ${TextConstants.login}',
            style: AppTypography.semiBold14Circular(
              color: UIColors.pineGreen,
            ),
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
