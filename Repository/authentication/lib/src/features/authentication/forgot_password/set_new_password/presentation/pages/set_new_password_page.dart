import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/widgets/password_field.dart';
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

import '../../../../../../core/services/routes/route_generator.dart';

part '../widgets/reset_password_form_builder.dart';

class SetNewPasswordPage extends ConsumerStatefulWidget {
  const SetNewPasswordPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConsumerState<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends ConsumerState<SetNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setNewPasswordProvider);
    final isValid = ref.watch(passwordValidityProvider).isValid;
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  PasswordField(controller: _passwordController),
                  if (!isValid) const PasswordValidationBuilder(),
                  PasswordField.confirm(
                      controller: _confirmPasswordController,
                      passwordController: _passwordController),
                ],
              ),
            ),
            SizedBox(height: 288.h),
            FilledButton(
              onPressed: isValid ? onButtonPressed : null,
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

    if (_formKey.currentState!.validate()) {
      notifier.newPasswordSubmit(
        email: widget.email,
        newPassword: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }

  void _navigateToSignIn() {
    ShowSnackBarMessage.showSuccessSnackBar(
      message: TextConstants.passwordResetSuccess,
      context: context,
    );

    router.go(Routes.signIn);
  }
}
