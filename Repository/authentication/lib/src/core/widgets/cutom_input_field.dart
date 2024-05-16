import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';

class CustomInputField extends StatefulWidget {
  CustomInputField({
    super.key,
    this.labelText,
    this.bottomMargin = 0.0,
    this.keyboardType,
    this.obscureText,
    this.obscuringCharacter = "•",
    this.password,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.suffix,
    this.readOnly = false,
    required this.textEditingController,
    this.prefix,
  })  : assert(obscuringCharacter.isNotNull && obscuringCharacter.length == 1),
        assert(
          !(password.isNotNull && obscureText.isNotNull),
          """Both can't be used at the same time. Use isPasswordTrue to handle password visibility internally. To handle externally use obscureText""",
        );

  /// Optional text that describes the input field.
  final String? labelText;

  /// Bottom margin to create space between intermediate element
  final double bottomMargin;

  /// The type of information for which to optimize the text input control.
  final TextInputType? keyboardType;

  /// Obscure text, helps with password visibility toggle.
  final bool? obscureText;

  /// Signature for validating a form field.
  ///
  /// Returns an error string to display if the input is invalid, or null
  /// otherwise.
  final String? Function(String?)? validator;

  /// Default '•'.
  final String obscuringCharacter;

  /// Treats the field as password field.
  ///
  /// Handles visibility toggle by default.
  /// Supports icon customization
  final EnabledPassword? password;

  final Function(String)? onChanged;

  // mandatory textediting Controller.
  // used for holding the state of the textfield.
  final TextEditingController textEditingController;

  final int? maxLength;

  final Widget? prefix;
  final Widget? suffix;

  final bool readOnly;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _showPassword = true;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomMargin),
      child: TextFormField(
        readOnly: widget.readOnly,
        controller: widget.textEditingController,
        validator: widget.validator,
        obscureText: widget.password.isNotNull
            ? _showPassword
            : widget.obscureText ?? false,
        obscuringCharacter: widget.obscuringCharacter,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        cursorColor: color.primary,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefix: widget.prefix,
          labelText: widget.labelText,
          suffix: widget.suffix,
          suffixIcon: widget.password.isNotNull
              ? _visibilityButton(widget.password!)
              : null,
        ),
      ),
    );
  }

  IconButton _visibilityButton(EnabledPassword password) {
    return IconButton(
      onPressed: () {
        setState(() => _showPassword = !_showPassword);
      },
      icon: _showPassword
          ? password.hidePasswordIcon ??
              Icon(
                Icons.visibility_off,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 16.sp,
              )
          : password.showPasswordIcon ??
              Icon(
                Icons.visibility,
                color: Theme.of(context).colorScheme.primary,
                size: 16.sp,
              ),
      splashColor: Colors.transparent,
    );
  }
}

class EnabledPassword {
  EnabledPassword({
    this.showPasswordIcon,
    this.hidePasswordIcon,
  });

  final Widget? showPasswordIcon;
  final Widget? hidePasswordIcon;
}

extension _GenericExtension<T> on T? {
  bool get isNotNull => this != null;
}

extension _StringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
