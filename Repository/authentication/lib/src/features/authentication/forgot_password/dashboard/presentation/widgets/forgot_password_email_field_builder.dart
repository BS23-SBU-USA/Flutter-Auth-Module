part of '../pages/forgot_password_page.dart';

class _EmailField extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const _EmailField({required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(forgotPasswordProvider.notifier);

    return Form(
      key: formKey,
      child: InputFormField(
        onChanged: (value) {
          ref.read(forgotPassButtonStateProvider.notifier).state =
              value.isNotEmpty;
        },
        textEditingController:
            ref.read(forgotPasswordEmailStateProvider.notifier).state,
        labelText: TextConstants.yourEmail,
        borderColor: UIColors.timberWolf,
        keyboardType: TextInputType.emailAddress,
        validator: InputValidators.email,
        autocorrect: false,
        borderType: BorderType.bottom,
        style: AppTypography.regular16Caros(),
        labelTextStyle: AppTypography.medium14Circular(
          color: UIColors.pineGreen,
        ),
      ),
    );
  }
}
