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

    final oldPasswordState =
        ref.read(changedOldPasswordStateProvider.notifier).state;
    final newPasswordState =
        ref.read(changedNewPasswordStateProvider.notifier).state;
    final confirmPasswordState =
        ref.read(changedConfirmPasswordStateProvider.notifier).state;

    final formKey = ref.read(changePasswordFormKeyStateProvider.notifier).state;

    return Form(
      key: formKey,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputField(
                textEditingController: oldPasswordState,
                labelText: TextConstants.oldPassword,
                keyboardType: TextInputType.visiblePassword,
                validator: InputValidators.password,
                bottomMargin: 30.h,
                password: EnabledPassword(),
              ),
              CustomInputField(
                onChanged: (value) {
                  ref
                      .read(passwordValidityProvider.notifier)
                      .updateValidationVariables(value);
                },
                textEditingController: newPasswordState,
                labelText: TextConstants.newPassword,
                keyboardType: TextInputType.visiblePassword,
                password: EnabledPassword(),
                bottomMargin: 0,
              ),
              if (ref.watch(passwordValidityProvider).isValid)
                Container(height: 20.h)
              else
                const PasswordValidationBuilder(),
              CustomInputField(
                textEditingController: confirmPasswordState,
                labelText: TextConstants.confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                password: EnabledPassword(),
                validator: (value) {
                  return InputValidators.confirmPassword(
                    value,
                    newPasswordState.text,
                  );
                },
                bottomMargin: 30.h,
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: state.status == ChangePasswordStatus.loading
                    ? null
                    : () {
                        if (formKey.currentState!.validate() &&
                            newPasswordState.text ==
                                confirmPasswordState.text) {
                          notifier.changePassword();
                        } else {
                          ShowSnackBarMessage.showErrorSnackBar(
                            message: TextConstants.passwordFieldsNotMatched,
                            context: context,
                          );
                        }
                      },
                child: state.status == ChangePasswordStatus.loading
                    ? Transform.scale(
                        scale: 0.75,
                        child: const CircularProgressIndicator(),
                      )
                    : const Text(
                        TextConstants.changePassword,
                      ),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Button(
              //         width: 327.sp,
              //         height: 48.sp,
              //         onPressed: () {
              //           FocusScope.of(context).unfocus();

              //           if (formKey.currentState!.validate() &&
              //               newPasswordState.text ==
              //                   confirmPasswordState.text) {
              //             notifier.changePassword();
              //           } else {
              //             ShowSnackBarMessage.showErrorSnackBar(
              //               message: TextConstants.passwordFieldsNotMatched,
              //               context: context,
              //             );
              //           }
              //         },
              //         isLoading: state.status == ChangePasswordStatus.loading,
              //         label: TextConstants.changePassword,
              //         textStyle: AppTypography.semiBold16Caros(
              //           color: UIColors.white,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
