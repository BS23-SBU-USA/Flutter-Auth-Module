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
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: Routes.signIn,
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

