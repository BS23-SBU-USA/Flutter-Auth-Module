import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/colors.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/cutom_input_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/presentation/riverpod/set_new_password_notifier.dart';
import 'package:auth_module/src/features/authentication/forgot_password/set_new_password/presentation/riverpod/set_new_password_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_back_button.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/password_validation_builder.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
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

    final isButtonEnabled = !ref.watch(passwordValidityProvider).isValid;

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
            OutlinedButton(
              onPressed: isButtonEnabled ? null : onButtonPressed,
              child: state.status == SetNewPasswordStatus.loading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : const Text(
                      TextConstants.resetPassword,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void onButtonPressed() {
    final notifier = ref.read(setNewPasswordProvider.notifier);

    final newPassword =
        ref.read(setNewPasswordStateProvider.notifier).state.text;

    final confirmPassword =
        ref.read(setConfirmPasswordStateProvider.notifier).state.text;

    if (ref
        .read(setNewPasswordFormKeyStateProvider.notifier)
        .state
        .currentState!
        .validate()) {
      if (newPassword == confirmPassword) {
        notifier.newPasswordSubmit();
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
