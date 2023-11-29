part of '../pages/change_password_page.dart';

class ChangePasswordFormBuilder extends ConsumerStatefulWidget {
  const ChangePasswordFormBuilder({
    super.key,
  });

  @override
  ConsumerState<ChangePasswordFormBuilder> createState() =>
      _ChangePasswordFormBuilderState();
}

class _ChangePasswordFormBuilderState
    extends ConsumerState<ChangePasswordFormBuilder> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final state = ref.watch(changePasswordProvider);
    final notifier = ref.read(changePasswordProvider.notifier);
    final oldPasswordSate =
        ref.read(changedOldPasswordStateProvider.notifier).state;
    final newPasswordSate =
        ref.read(changedNewPasswordStateProvider.notifier).state;
    final confirmPasswordSate =
        ref.read(changedConfirmPasswordStateProvider.notifier).state;

    return Form(
      key: formKey,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputFormField(
                textEditingController: oldPasswordSate,
                labelText: TextConstants.oldPassword,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                validator: InputValidators.password,
                borderType: BorderType.bottom,
                style: AppTypography.regular16Caros(),
                labelTextStyle: AppTypography.medium14Circular(
                  color: UIColors.pineGreen,
                ),
                bottomMargin: 30.h,
                password: EnabledPassword(),
              ),
              InputFormField(
                onChanged: (value) {
                  ref
                      .read(passwordValidityProvider.notifier)
                      .updateValidationVariables(value);
                },
                textEditingController: newPasswordSate,
                labelText: TextConstants.newPassword,
                keyboardType: TextInputType.visiblePassword,
                borderType: BorderType.bottom,
                style: AppTypography.regular16Caros(),
                labelTextStyle: AppTypography.medium14Circular(
                  color: UIColors.pineGreen,
                ),
                password: EnabledPassword(),
                autocorrect: false,
                bottomMargin: 0,
              ),
              if (ref.watch(passwordValidityProvider).isValid)
                Container(height: 20.h)
              else
                const PasswordValidationBuilder(),
              InputFormField(
                textEditingController: confirmPasswordSate,
                labelText: TextConstants.confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                password: EnabledPassword(),
                validator: (value) {
                  return InputValidators.confirmPassword(
                    value,
                    ref
                        .read(changedNewPasswordStateProvider.notifier)
                        .state
                        .text,
                  );
                },
                borderType: BorderType.bottom,
                style: AppTypography.regular16Caros(),
                labelTextStyle: AppTypography.medium14Circular(
                  color: UIColors.pineGreen,
                ),
                bottomMargin: 30.h,
                autocorrect: false,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      width: 327.sp,
                      height: 48.sp,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (newPasswordSate.text == confirmPasswordSate.text) {
                          notifier.changePassword();
                        }
                      },
                      isLoading: state.status == ChangePasswordStatus.loading,
                      label: TextConstants.changePassword,
                      textStyle: AppTypography.semiBold16Caros(
                        color: UIColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
