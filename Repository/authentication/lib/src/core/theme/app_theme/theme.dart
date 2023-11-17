import 'package:auth_module/src/core/theme/app_theme/style.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final AppStyle appStyle;

  const AppTheme({
    Key? key,
    required this.appStyle,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static AppStyle of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!.appStyle;
  }
}
