part of '../pages/forgot_password_page.dart';

class _EmailField extends ConsumerWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(forgotPasswordProvider.notifier);

    return Form(
      key: notifier.formKey,
      child: InputFormField(
        onChanged: (value) {
          ref.read(forgotPassButtonStateProvider.notifier).state =
              value.isNotEmpty;
        },
        textEditingController: notifier.emailController,
        labelText: TextConstants.yourEmail,
        keyboardType: TextInputType.emailAddress,
        validator: InputValidators.email,
        autocorrect: false,
        borderType: BorderType.bottom,
        labelTextStyle: AppTypography.bold14(
          color: UIColors.secondary,
        ),
      ),
    );
  }
}
