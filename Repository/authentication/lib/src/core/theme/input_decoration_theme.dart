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
//   static InputDecorationTheme light() {
//     return _inputDecorationTheme.copyWith(
//       labelStyle: CustomLabelStyle.light(),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: CustomBorderSide.light(),
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: CustomBorderSide.light(),
//       ),
//       errorBorder: UnderlineInputBorder(
//         borderSide: CustomBorderSide.light(),
//       ),
//     );
//   }

//   static InputDecorationTheme dark() {
//     return _inputDecorationTheme.copyWith(
//       labelStyle: CustomLabelStyle.dark(),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: CustomBorderSide.dark(),
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: CustomBorderSide.dark(),
//       ),
//       errorBorder: UnderlineInputBorder(
//         borderSide: CustomBorderSide.dark(),
//       ),
//     );
//   }
// }

// class CustomLabelStyle extends TextStyle {

//   final ColorScheme scheme;

//   const CustomLabelStyle({required this.scheme})
//       : super(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           letterSpacing: 0.1,
//           color: scheme.primary,
//         );
//   static const TextStyle _labelStyle = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0.1,
//     fontFamily: 'Circular',
//   );

//   static TextStyle light() {
//     return _labelStyle.copyWith(
//       color: lightColorScheme.primary,
//     );
//   }

//   static TextStyle dark() {
//     return _labelStyle.copyWith(
//       color: darkColorScheme.primary,
//     );
//   }
// }

// class CustomBorderSide {
//   static const BorderSide _borderSide = BorderSide();

//   static BorderSide light() {
//     return _borderSide.copyWith(
//       color: lightColorScheme.primary,
//     );
//   }

//   static BorderSide dark() {
//     return _borderSide.copyWith(
//       color: darkColorScheme.primary,
//     );
//   }
// }

// class CustomInputFieldTheme extends ThemeExtension<CustomInputFieldTheme> {
//   final ColorScheme scheme;
//   const CustomInputFieldTheme({required this.scheme});

//   @override
//   CustomInputFieldTheme copyWith({ColorScheme? scheme}) {
//     return CustomInputFieldTheme(
//       scheme: scheme ?? this.scheme,
//     );
//   }

//   @override
//   CustomInputFieldTheme lerp(
//       ThemeExtension<CustomInputFieldTheme>? other, double t) {
//     if (other is! CustomInputFieldTheme) {
//       return this;
//     }
//     return CustomInputFieldTheme(
//       scheme: ColorScheme.lerp(scheme, other.scheme, t),
//     );
//   }
// }
