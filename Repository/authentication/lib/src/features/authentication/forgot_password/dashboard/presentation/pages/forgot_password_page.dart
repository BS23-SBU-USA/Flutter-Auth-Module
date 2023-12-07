import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/colors.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
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
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordProvider);
    final notifier = ref.read(forgotPasswordProvider.notifier);

    ref.listen(
      forgotPasswordProvider,
      (_, next) {
        if (next.status == ForgotPasswordStatus.success) {
          _navigateToIdentityVerificationPage(
              ref.read(forgotPasswordEmailStateProvider.notifier).state.text);
        } else if (next.status == ForgotPasswordStatus.failure) {
          ShowSnackBarMessage.showErrorSnackBar(
            message: next.errorMessage,
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
          const _EmailField(),
          SizedBox(height: 347.h),
          Button(
            onPressed: () {
              if (ref
                  .read(forgotPasswordFormKeyStateProvider.notifier)
                  .state
                  .currentState!
                  .validate()) {
                notifier.forgotPasswordSubmit();
              }
            },
            isLoading: state.status == ForgotPasswordStatus.loading,
            label: TextConstants.submit,
            textStyle: !ref.watch(forgotPassButtonStateProvider)
                ? AppTypography.semiBold16Caros(color: UIColors.gray)
                : AppTypography.semiBold16Caros(color: UIColors.white),
            disable: !ref.watch(forgotPassButtonStateProvider),
          ),
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
