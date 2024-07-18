import 'package:flutter/material.dart';
import 'typography/fonts.dart';

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
    inputDecorationTheme: CustomInputDecorationTheme(scheme: lightColorScheme),
    filledButtonTheme: FilledButtonThemeData(
      style: CustomFilledButtonStyle(scheme: lightColorScheme),
    ),
    appBarTheme: CustomAppBarTheme(scheme: lightColorScheme),
    fontFamily: FontConstants.fontFamilyCaros,
    focusColor: lightColorScheme.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightColorScheme.background,
    textTheme: const CustomTextTheme().apply(
      displayColor: lightColorScheme.onBackground,
      bodyColor: lightColorScheme.onBackground,
    ),
    dividerTheme: DividerThemeData(
      color: lightColorScheme.surfaceVariant,
      thickness: 1,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    appBarTheme: CustomAppBarTheme(scheme: darkColorScheme),
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: darkColorScheme.primary),
    inputDecorationTheme: CustomInputDecorationTheme(scheme: darkColorScheme),
    filledButtonTheme: FilledButtonThemeData(
      style: CustomFilledButtonStyle(scheme: darkColorScheme),
    ),
    fontFamily: FontConstants.fontFamilyCaros,
    focusColor: darkColorScheme.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkColorScheme.background,
    textTheme: const CustomTextTheme().apply(
      displayColor: darkColorScheme.onBackground,
      bodyColor: darkColorScheme.onBackground,
    ),
    dividerTheme: DividerThemeData(
      color: darkColorScheme.onSurfaceVariant,
      thickness: 1,
    ),
  );

  static ThemeData get lightTheme => _lightTheme;

  static ThemeData get darkTheme => _darkTheme;
}
