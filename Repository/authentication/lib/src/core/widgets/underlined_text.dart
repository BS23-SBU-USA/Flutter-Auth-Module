import 'package:auth_module/src/core/theme/app_theme/context_extension.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnderlinedText extends StatelessWidget {
  const UnderlinedText({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: 8.h,
          width: 50.w,
          color: UIColors.verdigris,
        ),
        Text(
          title,
          style: context.theme.text.semiBold18Caros
              .copyWith(color: context.theme.color.black),
        ),
      ],
    );
  }
}
