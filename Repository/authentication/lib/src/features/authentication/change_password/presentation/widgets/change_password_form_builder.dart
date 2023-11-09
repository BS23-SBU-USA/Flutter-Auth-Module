part of '../pages/change_password_page.dart';

class ChangePasswordFormBuilder extends ConsumerStatefulWidget {
  const ChangePasswordFormBuilder({super.key});

  @override
  ConsumerState<ChangePasswordFormBuilder> createState() =>
      _ChangePasswordFormBuilderState();
}

class _ChangePasswordFormBuilderState
    extends ConsumerState<ChangePasswordFormBuilder> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordProvider);
    final notifier = ref.read(changePasswordProvider.notifier);
    final offlineState = ref.watch(offlineStateProvider);

    return Form(
      key: notifier.formKey,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputFormField(
                textEditingController: notifier.oldPasswordController,
                labelText: TextConstants.oldPassword,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                validator: InputValidators.password,
                borderType: BorderType.bottom,
                style: AppTypography.regular16(),
                labelTextStyle: AppTypography.bold14(
                  color: UIColors.secondary,
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
                textEditingController: notifier.newPasswordController,
                labelText: TextConstants.newPassword,
                keyboardType: TextInputType.visiblePassword,
                borderType: BorderType.bottom,
                style: AppTypography.regular16(),
                labelTextStyle: AppTypography.bold14(
                  color: UIColors.secondary,
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
                textEditingController: notifier.confirmPasswordController,
                labelText: TextConstants.confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                password: EnabledPassword(),
                validator: (value) {
                  return InputValidators.confirmPassword(
                    value,
                    notifier.newPasswordController.text,
                  );
                },
                borderType: BorderType.bottom,
                style: AppTypography.regular16(),
                labelTextStyle: AppTypography.bold14(
                  color: UIColors.secondary,
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
                        notifier.changePassword(offlineState);
                      },
                      isLoading: state.status == ChangePasswordStatus.loading,
                      label: TextConstants.changePassword,
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
