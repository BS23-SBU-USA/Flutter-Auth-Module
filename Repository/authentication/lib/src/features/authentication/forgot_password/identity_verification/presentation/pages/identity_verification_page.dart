import 'dart:developer';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/cutom_input_field.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/riverpod/forgot_password_provider.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/riverpod/identity_verification_notifier.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/riverpod/identity_verification_providers.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/widgets/countdown_timer.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_back_button.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/model/user_model.dart';
import 'package:auth_module/src/features/authentication/sign_up/presentation/riverpod/sign_up_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/services/routes/route_generator.dart';

part '../widgets/otp_field_builder.dart';

class IdentityVerificationPage extends ConsumerStatefulWidget {
  const IdentityVerificationPage({
    required this.isFromSignUp,
    super.key,
    required this.email,
  });

  final String email;
  final bool isFromSignUp;

  @override
  ConsumerState<IdentityVerificationPage> createState() =>
      _IdentityVerificationPageState();
}

class _IdentityVerificationPageState
    extends ConsumerState<IdentityVerificationPage> {
  bool isButtonEnabled = false;
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    ref.read(otpStateProvider.notifier).state.clear();

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

    final theme = Theme.of(context);
    final color = theme.colorScheme;
    // !!: Do we really need this
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
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                validator: InputValidators.otp,
                decoration: const InputDecoration(
                  labelText: TextConstants.yourCode,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                ],
              ),
            ),
            SizedBox(height: 347.h),
            StatefulBuilder(builder: (context, reload) {
              _otpController.addListener(() {
                if (_otpController.text.length > 4) {
                  reload(() {});
                }
              });
              return FilledButton(
                onPressed: state.isLoading || _otpController.text.length < 6
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          onButtonPressed(state, context);
                        }
                      },
                child: state.isLoading
                    ? Transform.scale(
                        scale: 0.75,
                        child: CircularProgressIndicator(
                          color: color.primary,
                        ),
                      )
                    : const Text(
                        TextConstants.submit,
                      ),
              );
            }),
            SizedBox(height: 16.h),
            const CountdownTimer(),
          ],
        ),
      ),
    );
  }

  void onButtonPressed(IdentityVerificationState state, BuildContext context) {
    log("email: ${widget.email}");
    FocusScope.of(context).unfocus();
    ref.read(identityVerificationProvider.notifier).identityVerificationSubmit(
          email: widget.email,
          otp: _otpController.text,
        );
  }

  // !!: Do we really need this?
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
                style: AppTypography.semiBold16Caros(color: UIColors.pineGreen),
              ),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: AppTypography.semiBold16Caros(color: UIColors.pineGreen),
              ),
              onPressed: () {
                context.pop();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToWelcomePage() {
    router.go(Routes.welcome);
  }

  void _navigateToResetPasswordPage() {
   router.push(Routes.resetPassword, extra: {
     'email': widget.email,
   });
  }
}
