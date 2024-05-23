import 'dart:developer';

import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/colors.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/cutom_input_field.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/riverpod/forgot_password_notifier.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/riverpod/forgot_password_provider.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/pages/identity_verification_page.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_back_button.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part '../widgets/forgot_password_email_field_builder.dart';

part '../widgets/sign_in_navigation_builder.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordProvider);
    final notifier = ref.read(forgotPasswordProvider.notifier);

    ref.listen(
      forgotPasswordProvider,
      (_, next) {
        if (next.status.isSuccess) {
          _navigateToIdentityVerificationPage(
              ref.read(forgotPasswordEmailStateProvider.notifier).state.text);
        } else if (next.status.isFailure) {
          ShowSnackBarMessage.showErrorSnackBar(
            message: next.error!,
            context: context,
          );
        }
      },
    );
    
    return ScrollableWrapper(
      floatingActionButton: const BuildBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BuildTitleAndSubtitle(
            titleFirstPart: TextConstants.dashboardTitleFirstPart,
            titleLastPart: TextConstants.dashboardTitleLastPart,
            subtitleFirstPart: TextConstants.dashboardSubtitleFirstPart,
            subtitleLastPart: TextConstants.dashboardSubtitleLastPart,
          ),
          SizedBox(height: 70.h),
          Form(
            child: TextFormField(
              controller: emailController,
              validator: InputValidators.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: TextConstants.yourEmail,
              ),
            ),
          ),
          SizedBox(height: 347.h),
          StatefulBuilder(builder: (context, reload) {
            emailController.addListener(() {
              if (emailController.text.isNotEmpty ||
                  emailController.text.isEmpty) {
                reload(() {});
              }
            });
            return FilledButton(
              onPressed: state.status.isLoading || emailController.text.isEmpty
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        notifier.forgotPasswordSubmit(
                          emailController.text,
                        );
                      }
                    },
              child: state.status.isLoading
                  ? Transform.scale(
                      scale: 0.75,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : const Text(
                      TextConstants.submit,
                    ),
            );
          }),
          SizedBox(height: 16.h),
          const _SignInNavigationBuilder(),
        ],
      ),
    );
  }

  void _navigateToIdentityVerificationPage(String email) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const IdentityVerificationPage(
          isFromSignUp: false,
        ),
      ),
    );
  }
}
