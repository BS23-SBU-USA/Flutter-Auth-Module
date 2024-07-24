part of 'theme.dart';

class CustomFilledButtonStyle extends ButtonStyle {
  final ColorScheme scheme;

  CustomFilledButtonStyle({required this.scheme})
      : super(
          
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled) ||
                  states.contains(MaterialState.selected)) {
                return scheme.primaryContainer;
              } else {
                return scheme.primary;
              }
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return scheme.onPrimaryContainer;
              } else {
                return scheme.onPrimary;
              }
            },
          ),
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: FontConstants.fontFamilyCaros,
            ),
          ),
          animationDuration: const Duration(milliseconds: 200),
          minimumSize: const MaterialStatePropertyAll(
            Size(double.infinity, 48),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        );
}
