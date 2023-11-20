import 'package:auth_module/src/core/theme/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTitleAndSubtitle extends StatelessWidget {
  const BuildTitleAndSubtitle({
    required this.titleFirstPart,
    required this.titleLastPart,
    required this.subtitleFirstPart,
    required this.subtitleLastPart,
    super.key,
  });

  final String titleFirstPart;
  final String titleLastPart;
  final String subtitleFirstPart;
  final String subtitleLastPart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Positioned(
                  bottom: -2,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 8.h,
                    color: context.theme.color.verdigris,
                  ),
                ),
                Text(
                  titleFirstPart,
                  style: context.theme.text.semiBold18Caros,
                ),
              ],
            ),
            Text(
              titleLastPart,
              style: context.theme.text.semiBold18Caros,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          '$subtitleFirstPart\n$subtitleLastPart',
          style: context.theme.text.medium14Circular
              .copyWith(color: context.theme.color.gray),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
