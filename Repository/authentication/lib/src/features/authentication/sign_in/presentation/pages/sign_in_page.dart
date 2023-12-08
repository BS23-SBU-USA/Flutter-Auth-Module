import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

part '../widgets/remember_me_and_forget_pass_builder.dart';

part '../widgets/sign_in_form_builder.dart';

part '../widgets/sign_up_navigation_builder.dart';

part '../widgets/single_sign_on.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      ref.read(signInProvider.notifier).getStoredCredentials();
      ref.read(signInProvider.notifier).decideNextRoute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonState = ref.watch(buttonStateProvider);
    final state = ref.watch(signInProvider);
    final notifier = ref.read(signInProvider.notifier);
    final logoState = ref.read(logoVisibilityStateProvider.notifier).state;
    final ssoState = ref.read(ssoVisibilityStateProvider.notifier).state;

    ref
      ..listen(
        signInProvider,
        (previous, next) {
          if (next.status == BaseStatus.failure) {
            ShowSnackBarMessage.showErrorSnackBar(
              message: next.error!,
              context: context,
            );
          } else if (next.status == BaseStatus.success) {
            navigateToDashboardPage();
          }
        },
      )
      ..listen(isUserLoggedInProvider, (_, next) {
        if (next) {
          navigateToDashboardPage();
        }
      });

    return ScrollableWrapper(
      appBar: AppBar(
        backgroundColor: UIColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          _buildOfflineButton(),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logoState
              ? _buildAppLogo()
              : const BuildTitleAndSubtitle(
                  titleFirstPart: TextConstants.signInTitleFirstPart,
                  titleLastPart: TextConstants.signInTitleLastPart,
                  subtitleFirstPart: TextConstants.signInSubtitleFirstPart,
                  subtitleLastPart: TextConstants.signInSubtitleLastPart,
                ),
          SizedBox(height: 30.h),
          if (ssoState) const SingleSignOn(),
          SizedBox(height: 30.h),
          const _SignInFormBuilder(),
          const _RememberMeAndForgetPassBuilder(),
          SizedBox(height: 177.h),
          Button(
            onPressed: () {
              if (ref
                  .read(signInFormKeyStateProvider.notifier)
                  .state
                  .currentState!
                  .validate()) {
                notifier.signIn();
              }
            },
            isLoading: state.status == BaseStatus.loading,
            label: TextConstants.login,
            textStyle: !buttonState
                ? AppTypography.semiBold16Caros(color: UIColors.gray)
                : AppTypography.semiBold16Caros(color: UIColors.white),
            disable: !buttonState,
          ),
          SizedBox(height: 16.h),
          const _SignUpNavigationBuilder(),
        ],
      ),
    );
  }

  Widget _buildOfflineButton() {
    final state = ref.watch(offlineStateProvider);
    final notifier = ref.read(offlineStateProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Row(
        children: [
          Text(
            TextConstants.offline,
            style: AppTypography.bold14Caros(
              color: UIColors.pineGreen,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: state,
              activeColor: UIColors.pineGreen,
              trackColor: UIColors.gray,
              thumbColor: UIColors.white,
              onChanged: (value) {
                notifier.state = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: UIColors.pineGreen, // Border color
        ),
      ),
      child: SvgPicture.asset(
        Assets.appLogo,
        height: 60.sp,
        colorFilter: const ColorFilter.mode(
          UIColors.pineGreen,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  void navigateToDashboardPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.home,
      (route) => false,
    );
  }
}
