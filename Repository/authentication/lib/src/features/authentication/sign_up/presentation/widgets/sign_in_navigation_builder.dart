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
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TextConstants.alreadyHaveAnAccount,
          style: textStyle.labelLarge!.copyWith(
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        GestureDetector(
          onTap: _navigateToSignInPage,
          child: Text(
            TextConstants.login,
            style: textStyle.labelLarge!.copyWith(
              fontWeight: FontWeightManager.semiBold,
              color: color.primary,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToSignInPage() {
    context.pop();
  }
}
