part of 'theme.dart';

class CustomInputDecorationTheme extends InputDecorationTheme {
  final ColorScheme scheme;

   CustomInputDecorationTheme({required this.scheme})
      : super(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w400,
          ),
          labelStyle:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color : scheme.primary,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: scheme.primary,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: scheme.primary,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: scheme.primary,
            ),
          ),
        );
}
