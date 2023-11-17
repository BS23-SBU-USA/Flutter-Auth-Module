import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/theme/app_theme/context_extension.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/riverpod/forgot_password_notifier.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/riverpod/identity_verification_notifier.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/riverpod/identity_verification_providers.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/widgets/countdown_timer.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_back_button.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/model/user_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:auth_module/src/features/authentication/sign_up/presentation/riverpod/sign_up_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part '../widgets/otp_field_builder.dart';

class IdentityVerificationPage extends ConsumerStatefulWidget {
  const IdentityVerificationPage({
    required this.isFromSignUp,
    super.key,
    this.user,
  });

  final UserModel? user;
  final bool isFromSignUp;

  @override
  ConsumerState<IdentityVerificationPage> createState() =>
      _IdentityVerificationPageState();
}

class _IdentityVerificationPageState
    extends ConsumerState<IdentityVerificationPage> {
  final formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  @override
  void initState() {
    var email = ref.read(forgotPasswordProvider.notifier).emailController.text;

    if (email.isEmpty) {
      email = ref.read(signUpProvider.notifier).emailController.text;
    }

    ref.read(identityVerificationProvider.notifier).otpController.clear();

    ref
        .read(identityVerificationProvider.notifier)
        .identityVerificationInitial(email: email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(identityVerificationProvider);

    ref.listen(
      identityVerificationProvider,
      (_, next) {
        if (next.status == IdentityVerificationStatus.success) {
          if (widget.isFromSignUp) {
            _navigateToWelcomePage();
          } else {
            _navigateToResetPasswordPage();
          }
        } else if (next.status == IdentityVerificationStatus.failure) {
          ShowSnackBarMessage.showErrorSnackBar(
            message: next.errorMessage,
            context: context,
          );
        }
      },
    );
    return WillPopScope(
      onWillPop: () async {
        _onPressed();
        return true;
      },
      child: ScrollableWrapper(
        floatingActionButton: const BuildBackButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BuildTitleAndSubtitle(
              titleFirstPart: TextConstants.identityVerificationTitleFirstPart,
              titleLastPart: TextConstants.identityVerificationTitleLastPart,
              subtitleFirstPart:
                  TextConstants.identityVerificationSubtitleFirstPart,
              subtitleLastPart:
                  TextConstants.identityVerificationSubtitleLastPart,
            ),
            SizedBox(height: 70.h),
            const _OtpField(),
            SizedBox(height: 347.h),
            Button(
              onPressed: () {
                onButtonPressed(state, context);
              },
              isLoading: state.status == IdentityVerificationStatus.loading,
              label: TextConstants.submit,
              textStyle: !ref.watch(otpButtonStateProvider)
                  ? context.theme.text.semiBold16Caros
                      .copyWith(color: context.theme.color.gray)
                  : context.theme.text.semiBold16Caros
                      .copyWith(color: context.theme.color.white),
              disable: !ref.watch(otpButtonStateProvider),
            ),
            SizedBox(height: 16.h),
            const CountdownTimer(),
          ],
        ),
      ),
    );
  }

  void onButtonPressed(IdentityVerificationState state, BuildContext context) {
    final offlineState = ref.watch(offlineStateProvider);
    FocusScope.of(context).unfocus();
    ref
        .read(identityVerificationProvider.notifier)
        .identityVerificationSubmit(offlineState);
  }

  void _onPressed() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(TextConstants.confirmation),
          content: const Text(TextConstants.wantToGoBack),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: context.theme.text.semiBold16Caros
                    .copyWith(color: context.theme.color.pineGreen),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: context.theme.text.semiBold16Caros
                    .copyWith(color: context.theme.color.pineGreen),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToWelcomePage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.welcome,
      (route) => false,
    );
  }

  void _navigateToResetPasswordPage() {
    Navigator.pushNamed(
      context,
      Routes.resetPassword,
    );
  }
}
