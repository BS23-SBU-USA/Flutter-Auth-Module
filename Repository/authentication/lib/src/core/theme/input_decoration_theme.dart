part of 'theme.dart';

class CustomInputDecorationTheme {
  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
    ),
    errorStyle: TextStyle(
      color: Color(0xFFFF2D1B),
      fontSize: 12,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
      fontFamily: 'Circular',
    ),
  );

  static InputDecorationTheme light() {
    return _inputDecorationTheme.copyWith(
      labelStyle: CustomLabelStyle.light(),
      enabledBorder: UnderlineInputBorder(
        borderSide: CustomBorderSide.light(),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: CustomBorderSide.light(),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: CustomBorderSide.light(),
      ),
    );
  }

  static InputDecorationTheme dark() {
    return _inputDecorationTheme.copyWith(
      labelStyle: CustomLabelStyle.dark(),
      enabledBorder: UnderlineInputBorder(
        borderSide: CustomBorderSide.dark(),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: CustomBorderSide.dark(),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: CustomBorderSide.dark(),
      ),
    );
  }
}

class CustomLabelStyle {
  static const TextStyle _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    fontFamily: 'Circular',
  );

  static TextStyle light() {
    return _labelStyle.copyWith(
      color: lightColorScheme.primary,
    );
  }

  static TextStyle dark() {
    return _labelStyle.copyWith(
      color: darkColorScheme.primary,
    );
  }
}

class CustomBorderSide {
  static const BorderSide _borderSide = BorderSide();

  static BorderSide light() {
    return _borderSide.copyWith(
      color: lightColorScheme.primary,
    );
  }

  static BorderSide dark() {
    return _borderSide.copyWith(
      color: darkColorScheme.primary,
    );
  }
}
