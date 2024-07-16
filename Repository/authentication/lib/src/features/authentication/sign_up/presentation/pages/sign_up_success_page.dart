import 'package:auth_module/src/core/services/routes/route_generator.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../gen/assets.gen.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: _navigateToSignInPage,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 6.sp,
            vertical: 8.sp,
          ),
          child: SvgPicture.asset(
            Assets.images.backIcon,
            colorFilter: ColorFilter.mode(
              color.onPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: color.background,
      body: Center(
        child: SizedBox(
          width: 400.w,
          height: 300.h,
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(TextConstants.congratulations,
                    style: text.titleLarge!.copyWith(
                      color: color.primary,
                    )),
                SizedBox(height: 20.h),
                Text(
                  TextConstants.accountCreatedSuccess,
                  style: text.bodyMedium,
                ),
                SizedBox(height: 30.h),
                FilledButton(
                    onPressed: _navigateToSignInPage,
                    child: const Text(TextConstants.login)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSignInPage() {
    router.go(Routes.signIn);
  }
}
