import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/change_password/presentation/riverpod/change_password_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/password_validation_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

part '../widgets/change_password_form_builder.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(changePasswordProvider, (_, next) {
      if (next.status == ChangePasswordStatus.success) {
        _onSuccess(context);
      } else if (next.status == ChangePasswordStatus.failure) {
        _onError(next, context);
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: UIColors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                SizedBox(width: 24.sp),
                SizedBox(
                  width: 24.sp,
                  height: 24.sp,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(
                      Assets.backIcon,
                      width: 8.sp,
                      height: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            SizedBox(height: 60.sp),
            const BuildTitleAndSubtitle(
              titleFirstPart: TextConstants.changePasswordTitleFirstPart,
              titleLastPart: TextConstants.changePasswordTitleLastPart,
              subtitleFirstPart: TextConstants.changePasswordSubtitleFirstPart,
              subtitleLastPart: TextConstants.changePasswordSubtitleLastPart,
            ),
            SizedBox(height: 70.sp),
            const ChangePasswordFormBuilder(),
            SizedBox(height: 40.sp),
          ],
        ),
      ),
    );
  }

  void _onSuccess(BuildContext context) {
    ShowSnackBarMessage.showSuccessSnackBar(
      message: TextConstants.passwordChangeSuccess,
      context: context,
    );
    _navigateToSignIn();
  }

  void _onError(ChangePasswordState state, BuildContext context) {
    ShowSnackBarMessage.showErrorSnackBar(
      message: state.errorMessage,
      context: context,
    );
  }

  void _navigateToSignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.signIn,
      (Route<dynamic> route) => false,
    );
  }
}
