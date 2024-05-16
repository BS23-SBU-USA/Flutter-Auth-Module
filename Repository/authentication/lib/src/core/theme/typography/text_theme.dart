part of '../theme.dart';



const TextStyle _titleMedium = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

class CustomTextTheme extends TextTheme {
  const CustomTextTheme():super(
    titleMedium: _titleMedium,
  );
}
