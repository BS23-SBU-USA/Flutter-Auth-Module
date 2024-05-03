import 'package:auth_module/src/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'typography/fonts.dart';
import 'typography/style.dart';

export 'colors.dart';

part 'color_scheme.dart';

part 'app_bar_theme.dart';

part 'outlined_button_theme.dart';

part 'input_decoration_theme.dart';
part 'typography/text_theme.dart';

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
      appBarTheme: CustomAppBarTheme(scheme: lightColorScheme),
      fontFamily: FontConstants.fontFamilyCaros,
      focusColor: lightColorScheme.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightColorScheme.background,
      textTheme: _textTheme,
    
      dividerTheme: DividerThemeData(
        color: lightColorScheme.surfaceVariant,
        thickness: 1,
      ));

  static final ThemeData _darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      appBarTheme: CustomAppBarTheme(scheme: darkColorScheme),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: darkColorScheme.primary),
      inputDecorationTheme: CustomInputDecorationTheme.dark(),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: CustomOutlinedButtonStyle.dark(),
      ),
      fontFamily: FontConstants.fontFamilyCaros,
      focusColor: darkColorScheme.primary,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkColorScheme.background,
      textTheme: _textTheme,
      dividerTheme: DividerThemeData(
        color: darkColorScheme.onSurfaceVariant,
        thickness: 1,
      ));

  static ThemeData get lightTheme => _lightTheme;

  static ThemeData get darkTheme => _darkTheme;
}
