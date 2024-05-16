import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/theme/typography/fonts.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_back_button.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/password_validation_builder.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_up/presentation/riverpod/sign_up_providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/cutom_input_field.dart';

part '../widgets/sign_in_navigation_builder.dart';

part '../widgets/sign_up_form_builder.dart';

part '../widgets/terms_and_condition_checker_builder.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final signUpFormState = ref.watch(signUpFormValidationProvider);
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    ref.listen(
      signUpProvider,
      (previous, next) {
        if (next.status == BaseStatus.failure) {
          ShowSnackBarMessage.showErrorSnackBar(
            message: next.error!,
            context: context,
          );
        } else if (next.status == BaseStatus.success) {
          _navigateToIdentityVerificationPage();
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
            titleFirstPart: TextConstants.signUpTitleFirstPart,
            titleLastPart: TextConstants.signUpTitleLastPart,
            subtitleFirstPart: TextConstants.signUpSubtitleFirstPart,
            subtitleLastPart: TextConstants.signUpSubtitleLastPart,
          ),
          SizedBox(height: 60.h),
          const SignUpFormBuilder(),
          SizedBox(height: 10.h),
          const TermsAndConditionCheckerBuilder(),
          SizedBox(height: 34.h),
          OutlinedButton(
            onPressed: signUpFormState
                ? () {
                    if (ref
                        .read(signUpFormKeyStateProvider.notifier)
                        .state
                        .currentState!
                        .validate()) {
                      signUpNotifier.signUp();
                    }
                  }
                : null,
            child: signUpState.status == BaseStatus.loading
                ? Transform.scale(
                    scale: 0.75,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : const Text(
                    TextConstants.createAnAccount,
                  ),
          ),
          // Button(
          //   onPressed: () {
          //     if (ref
          //         .read(signUpFormKeyStateProvider.notifier)
          //         .state
          //         .currentState!
          //         .validate()) {
          //       signUpNotifier.signUp();
          //     }
          //   },
          //   isLoading: signUpState.status == BaseStatus.loading,
          //   label: TextConstants.createAnAccount,
          //   textStyle: !signUpFormState
          //       ? AppTypography.semiBold16Caros(color: UIColors.gray)
          //       : AppTypography.semiBold16Caros(color: UIColors.white),
          //   disable: !signUpFormState,
          // ),
          SizedBox(height: 16.h),
          const _SignInNavigationBuilder(),
          SizedBox(height: 37.h),
        ],
      ),
    );
  }

  void _navigateToIdentityVerificationPage() {
    Navigator.pushNamed(
      context,
      Routes.identityVerification,
      arguments: {
        'isFromSignUp': true,
        'email': ref.read(signUpEmailStateProvider.notifier).state.text,
      },
    );
  }
}
