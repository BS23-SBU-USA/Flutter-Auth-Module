import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/theme/app_theme/context_extension.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/colors.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/riverpod/forgot_password_notifier.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/presentation/riverpod/set_new_password_notifier.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_back_button.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/password_validation_builder.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part '../widgets/reset_password_form_builder.dart';

class SetNewPasswordPage extends ConsumerStatefulWidget {
  const SetNewPasswordPage({
    super.key,
  });

  @override
  ConsumerState<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends ConsumerState<SetNewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setNewPasswordProvider);

    ref.listen(
      setNewPasswordProvider,
      (_, next) {
        if (next.status == SetNewPasswordStatus.success) {
          _navigateToSignIn();
        } else if (next.status == SetNewPasswordStatus.failure) {
          ShowSnackBarMessage.showErrorSnackBar(
            message: next.errorMessage,
            context: context,
          );
        }
      },
    );

    return Scaffold(
      body: ScrollableWrapper(
        floatingActionButton: const BuildBackButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BuildTitleAndSubtitle(
              titleFirstPart: TextConstants.setPasswordTitleFirstPart,
              titleLastPart: TextConstants.setPasswordTitleLastPart,
              subtitleFirstPart: TextConstants.setPasswordSubtitleFirstPart,
              subtitleLastPart: TextConstants.setPasswordSubtitleLastPart,
            ),
            SizedBox(height: 70.h),
            const _ResetPasswordFormBuilder(),
            SizedBox(height: 288.h),
            Button(
              onPressed: onButtonPressed,
              isLoading: state.status == SetNewPasswordStatus.loading,
              label: TextConstants.resetPassword,
              textStyle: !ref.watch(passwordValidityProvider).isValid
                  ? context.theme.text.semiBold16Caros
                      .copyWith(color: context.theme.color.gray)
                  : context.theme.text.semiBold16Caros
                      .copyWith(color: context.theme.color.white),
              disable: !ref.watch(passwordValidityProvider).isValid,
            ),
          ],
        ),
      ),
    );
  }

  void onButtonPressed() {
    final notifier = ref.read(setNewPasswordProvider.notifier);
    final email =
        ref.read(forgotPasswordProvider.notifier).emailController.text;
    final offlineState = ref.watch(offlineStateProvider);

    if (notifier.formKey.currentState!.validate()) {
      if (notifier.newPasswordController.text ==
          notifier.confirmPasswordController.text) {
        notifier.newPasswordSubmit(email, offlineState);
      } else {
        ShowSnackBarMessage.showErrorSnackBar(
          message: TextConstants.passwordFieldsNotMatched,
          context: context,
        );
      }
    }
  }

  void _navigateToSignIn() {
    ShowSnackBarMessage.showSuccessSnackBar(
      message: TextConstants.passwordResetSuccess,
      context: context,
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.signIn,
      (Route<dynamic> route) => false,
    );
  }
}
