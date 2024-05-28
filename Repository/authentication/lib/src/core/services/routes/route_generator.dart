import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/features/authentication/change_password/presentation/pages/change_password_page.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/pages/forgot_password_page.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/pages/identity_verification_page.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/presentation/pages/set_new_password_page.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/pages/sign_in_page.dart';
import 'package:auth_module/src/features/authentication/sign_up/presentation/pages/sign_up_page.dart';
import 'package:auth_module/src/features/authentication/sign_up/presentation/pages/sign_up_success_page.dart';
import 'package:auth_module/src/features/authentication/sign_up/presentation/pages/web_view_page.dart';
import 'package:auth_module/src/features/home/presentation/pages/home_page.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/pages/update_profile_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static void get controller {}

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );

      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInPage(),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
        );

      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => const SuccessPage());

      case Routes.webView:
        return MaterialPageRoute(
          builder: (_) => WebViewPage(
            url: routeSettings.arguments! as String,
          ),
        );

      case Routes.resetPassword:

        return MaterialPageRoute(
          builder: (_) => SetNewPasswordPage(
            email: routeSettings.arguments! as String,
          ),
        );

      case Routes.changePassword:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordPage(),
        );

      case Routes.updateProfile:
        return MaterialPageRoute(
          builder: (_) => const UpdateProfilePage(),
        );

      case Routes.identityVerification:
        final arguments = routeSettings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => IdentityVerificationPage(
            email: arguments['email'] as String,
            isFromSignUp: arguments['isFromSignUp'] as bool,
          ),
        );

      default:
        return null;
    }
  }
}
