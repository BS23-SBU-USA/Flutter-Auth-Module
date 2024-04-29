import 'package:auth_module/src/core/services/local_storage/cache_service.dart';
import 'package:auth_module/src/core/services/routes/route_generator.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/theme/colors.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/loggers/riverpod_logger.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void logoutOnUnauthorizedError() {
  CacheService.instance.clearBearerToken();
  CacheService.instance.clearFullName();
  CacheService.instance.clearProfileId();

  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute<void>(
      builder: (_) => const SignInPage(),
    ),
    (route) => false,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    ProviderScope(
      observers: [RiverpodLogger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: TextConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: UIColors.pineGreen),
            inputDecorationTheme: const InputDecorationTheme(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              labelStyle: TextStyle(
                color: UIColors.pineGreen,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
                fontFamily: 'Circular',
              ),
              errorStyle: TextStyle(
                color: Color(0xFFFF2D1B),
                fontSize: 12,
                letterSpacing: 0.1,
                fontWeight: FontWeight.w400,
                fontFamily: 'Circular',
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: UIColors.timberWolf,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: UIColors.pineGreen,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: UIColors.red,
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: const MaterialStatePropertyAll(
                    BorderSide(color: UIColors.transparent)),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled) ||
                        states.contains(MaterialState.selected)) {
                      return UIColors.antiFlashWhite;
                    } else {
                      return UIColors.pineGreen;
                    }
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return UIColors.gray;
                    } else {
                      return UIColors.white;
                    }
                  },
                ),
                textStyle: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return AppTypography.semiBold16Caros(
                          color: UIColors.gray);
                    } else {
                      return AppTypography.semiBold16Caros(
                          color: UIColors.white);
                    }
                  },
                ),
                animationDuration: const Duration(milliseconds: 200),
                minimumSize: const MaterialStatePropertyAll(
                  Size(double.infinity, 48),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: UIColors.white,
              elevation: 0,
              titleSpacing: 0,
              centerTitle: true,
              titleTextStyle: AppTypography.semiBold18Caros(
                color: UIColors.black,
              ),
              iconTheme: const IconThemeData(
                color: UIColors.black,
              ),
            ),
          ),
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: Routes.signIn,
          navigatorKey: navigatorKey,
        );
      },
    );
  }
}
