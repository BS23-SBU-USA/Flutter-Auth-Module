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
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.signUp,
      builder: (_, __) => const SignUpPage(),
      name: Routes.signUp,
    ),
    GoRoute(
      path: Routes.signIn,
      builder: (_, __) => const SignInPage(),
      name: Routes.signIn,
    ),
    GoRoute(
      path: Routes.home,
      builder: (_, __) => const HomePage(),
      name: Routes.home,
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (_, __) => const ForgotPasswordPage(),
      name: Routes.forgotPassword,
    ),
    GoRoute(
      path: Routes.welcome,
      builder: (_, __) => const SuccessPage(),
      name: Routes.welcome,
    ),
    GoRoute(
      path: Routes.webView,
      builder: (context, state) => WebViewPage(url: state.extra as String),
      name: Routes.webView,
    ),
    GoRoute(
      path: Routes.resetPassword,
      builder: (_, state) => SetNewPasswordPage(
        email: state.extra as String,
      ),
      name: Routes.resetPassword,
    ),
    GoRoute(
      path: Routes.changePassword,
      builder: (_, __) => const ChangePasswordPage(),
      name: Routes.changePassword,
    ),
    GoRoute(
      path: Routes.updateProfile,
      builder: (_, __) => const UpdateProfilePage(),
      name: Routes.updateProfile,
    ),
    GoRoute(
      path: Routes.identityVerification,
      builder: (_, state) {
        final params = state.extra as Map<String, dynamic>;
        return  IdentityVerificationPage(
          email: params['email'] as String,
          isFromSignUp: params['isFromSignUp'] as bool,
        );
      },
      name: Routes.identityVerification,
    ),
  ],
);

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
