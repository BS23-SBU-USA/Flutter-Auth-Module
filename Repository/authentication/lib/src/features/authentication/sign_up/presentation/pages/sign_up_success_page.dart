import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: _navigateToSignInPage,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 6.sp,
            vertical: 8.sp,
          ),
          child: SvgPicture.asset(
            Assets.backIcon,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: UIColors.primary,
      body: Center(
        child: SizedBox(
          width: 400.w,
          height: 300.h,
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TextConstants.congratulations,
                  style: AppTypography.bold24(
                    color: UIColors.green,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  TextConstants.accountCreatedSuccess,
                  style: AppTypography.regular14(),
                ),
                SizedBox(height: 30.h),
                Button(
                  onPressed: _navigateToSignInPage,
                  label: TextConstants.login,
                  textStyle: AppTypography.bold16(color: UIColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSignInPage() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.signIn, (route) => false);
  }
}
