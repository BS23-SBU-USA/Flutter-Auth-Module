part of '../pages/sign_in_page.dart';

class _SignInFormBuilder extends ConsumerWidget {
  const _SignInFormBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(signInFormKeyStateProvider.notifier).state,
      child: Column(
        children: [
          CustomInputFied(
            textEditingController:
                ref.read(signInEmailStateProvider.notifier).state,
            labelText: TextConstants.yourEmail,
            bottomMargin: 30.h,
            validator: InputValidators.email,
            onChanged: (value) {
              final emailNotEmpty = value.isNotEmpty;
              final passwordNotEmpty = ref
                  .read(signInPasswordStateProvider.notifier)
                  .state
                  .text
                  .isNotEmpty;

              ref.read(buttonStateProvider.notifier).state =
                  emailNotEmpty && passwordNotEmpty;
            },
          ),
          CustomInputFied(
            textEditingController:
                ref.read(signInPasswordStateProvider.notifier).state,
            labelText: TextConstants.password,
            keyboardType: TextInputType.visiblePassword,
            password: EnabledPassword(),
            validator: InputValidators.password,
            onChanged: (value) {
              final passwordNotEmpty = value.isNotEmpty;
              final emailNotEmpty = ref
                  .read(signInEmailStateProvider.notifier)
                  .state
                  .text
                  .isNotEmpty;
              ref.read(buttonStateProvider.notifier).state =
                  emailNotEmpty && passwordNotEmpty;
            },
          ),
          // InputFormField(
          //   textEditingController:
          //       ref.read(signInEmailStateProvider.notifier).state,
          //   labelText: TextConstants.yourEmail,
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   style: AppTypography.regular16Caros(),
          //   keyboardType: TextInputType.emailAddress,
          //   validator: InputValidators.email,
          //   autocorrect: false,
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   bottomMargin: 30.h,
          //   onChanged: (value) {
          //     final emailNotEmpty = value.isNotEmpty;
          //     final passwordNotEmpty = ref
          //         .read(signInPasswordStateProvider.notifier)
          //         .state
          //         .text
          //         .isNotEmpty;

          //     ref.read(buttonStateProvider.notifier).state =
          //         emailNotEmpty && passwordNotEmpty;
          //   },
          // ),
          // InputFormField(
          //   textEditingController:
          //       ref.read(signInPasswordStateProvider.notifier).state,
          //   bottomMargin: 0,
          //   labelText: TextConstants.password,
          //   labelTextStyle: AppTypography.medium14Circular(
          //     color: UIColors.pineGreen,
          //   ),
          //   style: AppTypography.regular16Caros(),
          //   keyboardType: TextInputType.visiblePassword,
          //   password: EnabledPassword(),
          //   validator: InputValidators.password,
          //   autocorrect: false,
          //   borderType: BorderType.bottom,
          //   borderColor: UIColors.timberWolf,
          //   onChanged: (value) {
          //     final passwordNotEmpty = value.isNotEmpty;
          //     final emailNotEmpty = ref
          //         .read(signInEmailStateProvider.notifier)
          //         .state
          //         .text
          //         .isNotEmpty;
          //     ref.read(buttonStateProvider.notifier).state =
          //         emailNotEmpty && passwordNotEmpty;
          //   },
          // ),
        ],
      ),
    );
  }
}

class CustomInputFied extends StatefulWidget {
  CustomInputFied({
    super.key,
    this.labelText,
    this.bottomMargin = 0.0,
    this.keyboardType,
    this.obscureText,
    this.obscuringCharacter = "•",
    this.password,
    required this.textEditingController,
    this.validator,
    this.onChanged,
  })  : assert(obscuringCharacter.isNotNull && obscuringCharacter.length == 1),
        assert(
          !(password.isNotNull && obscureText.isNotNull),
          """Both can't be used at the same time. Use isPasswordTrue to handle password visibility internally. To handle externally use obscureText""",
        );

  // Mandatory textEditingController
  final TextEditingController textEditingController;

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

  @override
  State<CustomInputFied> createState() => _CustomInputFiedState();
}

class _CustomInputFiedState extends State<CustomInputFied> {
  bool _showPassword = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_clearError);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_clearError);
    super.dispose();
  }

  void _clearError() {
    if (isError) {
      setState(() {
        isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomMargin),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: widget.password.isNotNull
            ? _showPassword
            : widget.obscureText ?? false,
        obscuringCharacter: widget.obscuringCharacter,
        cursorColor: UIColors.pineGreen,
        keyboardType: widget.keyboardType,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: UIColors.black,
          fontFamily: 'Caros',
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: widget.password.isNotNull
              ? _visibilityButton(widget.password!)
              : _suffixPrefixPlaceHolder(),
        ),
      ),
    );
  }

  Widget? _suffixPrefixPlaceHolder() => const SizedBox.shrink();

  IconButton _visibilityButton(EnabledPassword password) {
    return IconButton(
      onPressed: () {
        setState(() => _showPassword = !_showPassword);
      },
      icon: _showPassword
          ? password.hidePasswordIcon ??
              Icon(
                Icons.visibility_off,
                color: UIColors.pineGreen,
                size: 16.sp,
              )
          : password.showPasswordIcon ??
              Icon(
                Icons.visibility,
                color: UIColors.pineGreen,
                size: 16.sp,
              ),
      splashColor: Colors.transparent,
    );
  }
}

extension _GenericExtension<T> on T? {
  bool get isNotNull => this != null;
}

extension _StringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
