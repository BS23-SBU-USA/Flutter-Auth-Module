part of '../theme.dart';

const TextStyle _titleMedium = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const TextStyle _titleLarge = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  
);

class CustomTextTheme extends TextTheme {
  const CustomTextTheme()
      : super(
          titleMedium: _titleMedium,
        );
}
