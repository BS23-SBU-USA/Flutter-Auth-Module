import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';

class BuildBackButton extends StatelessWidget {
  const BuildBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.sp,
          vertical: 10.sp,
        ),
        child: SvgPicture.asset(
          Assets.images.backIcon,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onBackground,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
