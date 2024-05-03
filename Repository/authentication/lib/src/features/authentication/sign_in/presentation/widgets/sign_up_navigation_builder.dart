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
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${TextConstants.doNotHaveAccount}  ',
          style: textStyle.labelLarge!.copyWith(
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        GestureDetector(
          onTap: _navigateToSignUpPage,
          child: Text(
            TextConstants.signUp,
            style: textStyle.labelLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: color.primary,
            ),
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
