part of 'theme.dart';

class CustomAppBarTheme extends AppBarTheme {
  final ColorScheme scheme;

  CustomAppBarTheme({
    required this.scheme,
  }) : super(
          backgroundColor: scheme.background,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: true,
          foregroundColor: scheme.onBackground,
        );
}
