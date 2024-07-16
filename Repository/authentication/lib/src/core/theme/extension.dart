import 'package:flutter/material.dart';

extension CustomThemeExtension on BuildContext {
  ColorScheme get color {
    return Theme.of(this).colorScheme;
  }

  TextTheme get text {
    return Theme.of(this).textTheme;
  }
}