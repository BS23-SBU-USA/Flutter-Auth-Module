import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/style.dart';
import 'package:flutter/material.dart';

extension AppStyleContextExtension on BuildContext {
  AppStyle get theme => AppTheme.of(this);
}
