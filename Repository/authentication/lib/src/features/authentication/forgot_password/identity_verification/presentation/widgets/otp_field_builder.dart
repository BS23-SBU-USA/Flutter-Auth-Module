part of '../pages/identity_verification_page.dart';

class _OtpField extends ConsumerWidget {
  const _OtpField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(identityVerificationProvider.notifier);

    return Form(
      key: notifier.formKey,
      child: InputFormField(
        onChanged: (value) {
          ref.read(otpButtonStateProvider.notifier).state = value.length >= 6;
        },
        textEditingController: notifier.otpController,
        labelText: TextConstants.yourCode,
        keyboardType: TextInputType.number,
        validator: InputValidators.otp,
        autocorrect: false,
        maxLength: 6,
        borderType: BorderType.bottom,
        labelTextStyle: AppTypography.bold14(
          color: UIColors.secondary,
        ),
      ),
    );
  }
}
