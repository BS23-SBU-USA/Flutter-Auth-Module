part of 'theme.dart';

class CustomOutlinedButtonStyle {
  static final ButtonStyle _style = ButtonStyle(
    side:
        const MaterialStatePropertyAll(BorderSide(color: UIColors.transparent)),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled) ||
            states.contains(MaterialState.selected)) {
          return lightColorScheme.primaryContainer;
        } else {
          return lightColorScheme.primary;
        }
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return lightColorScheme.onPrimaryContainer;
        } else {
          return lightColorScheme.onPrimary;
        }
      },
    ),
    textStyle: MaterialStatePropertyAll(
      AppTypography.semiBold16Caros(),
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

  static ButtonStyle light() {
    return _style;
  }

  static ButtonStyle dark() {
    return _style.copyWith(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled) ||
              states.contains(MaterialState.selected)) {
            return darkColorScheme.primaryContainer;
          } else {
            return darkColorScheme.primary;
          }
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return darkColorScheme.onPrimaryContainer;
          } else {
            return darkColorScheme.onPrimary;
          }
        },
      ),
    );
  }
}
