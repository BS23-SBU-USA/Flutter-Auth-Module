import 'package:auth_module/src/core/theme/app_theme/theme.dart';
import 'package:auth_module/src/core/theme/app_theme/style.dart';
import 'package:flutter/material.dart';

extension AppStyleContextExtension on BuildContext {
  AppStyle get theme => AppTheme.of(this);
}
