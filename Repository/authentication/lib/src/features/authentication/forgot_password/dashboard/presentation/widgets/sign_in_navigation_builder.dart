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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TextConstants.rememberYourPassword,
          style: textTheme.labelLarge,
        ),
        GestureDetector(
          onTap: _navigateToSignInPage,
          child: Text(' ${TextConstants.login}',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
              )),
        ),
      ],
    );
  }

  void _navigateToSignInPage() {
    Navigator.pop(context);
  }
}
