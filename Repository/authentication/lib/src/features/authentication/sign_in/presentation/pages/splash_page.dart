import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Future<void> _initializeData() async {
    ref.read(signInProvider.notifier).authConfigure();
  }

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = ref.watch(isUserLoggedInProvider);

    ref.listen(isUserLoggedInProvider, (_, next) {
      if (next) {
        navigateToDashboardPage();
      }
    });

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _initializeData(),
          builder: (context, snapshot) {
            if (!isUserLoggedIn &&
                snapshot.connectionState == ConnectionState.done) {
              Future.delayed(Duration.zero, () {
                navigateToSignInPage();
              });
            }

            return Container(
              height: 100.sp,
              width: 100.sp,
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: UIColors.pineGreen,
                  width: 5.r,
                ),
              ),
              child: SvgPicture.asset(
                Assets.appLogo,
                colorFilter: const ColorFilter.mode(
                  UIColors.pineGreen,
                  BlendMode.srcIn,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToSignInPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.signIn,
      (route) => false,
    );
  }

  void navigateToDashboardPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.home,
      (route) => false,
    );
  }
}
