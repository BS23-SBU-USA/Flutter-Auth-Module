import 'package:auth_module/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

import 'typography/style.dart';

export 'colors.dart';

part 'color_scheme.dart';

part 'app_bar_theme.dart';

part 'outlined_button_theme.dart';


part 'input_decoration_theme.dart';

class GlobalThemeData {
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textSelectionTheme:
         TextSelectionThemeData(cursorColor: lightColorScheme.primary),
    inputDecorationTheme: CustomInputDecorationTheme.light(),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: CustomOutlinedButtonStyle.light(),
    ),
    appBarTheme: CustomAppBarTheme.light(),
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    appBarTheme: CustomAppBarTheme.dark(),
    textSelectionTheme:
         TextSelectionThemeData(cursorColor: darkColorScheme.primary),
    inputDecorationTheme: CustomInputDecorationTheme.dark(),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: CustomOutlinedButtonStyle.dark(),
    ),
  );

  static ThemeData get lightTheme => _lightTheme;

  static ThemeData get darkTheme => _darkTheme;
}
