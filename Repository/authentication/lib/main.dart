import 'package:auth_module/src/core/services/local_storage/cache_service.dart';
import 'package:auth_module/src/core/services/routes/route_generator.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/utils/loggers/riverpod_logger.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void logoutOnUnauthorizedError() {
  CacheService.instance.clearBearerToken();
  CacheService.instance.clearFullName();
  CacheService.instance.clearProfileId();
  router.go(Routes.signIn);
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
        return MaterialApp.router(
          title: TextConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: GlobalThemeData.lightTheme,
          darkTheme: GlobalThemeData.darkTheme,       
          routerConfig: router,
        );
      },
    );
  }
}
