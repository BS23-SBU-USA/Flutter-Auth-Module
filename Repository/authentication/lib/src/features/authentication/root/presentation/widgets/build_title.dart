import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/fonts.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
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
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;
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
                    color: color.primary.withOpacity(0.75),
                  ),
                ),
                Text(
                  titleFirstPart,
                  style: textStyle.titleMedium,
                ),
              ],
            ),
            Text(
              titleLastPart,
              style: textStyle.titleMedium,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          '$subtitleFirstPart\n$subtitleLastPart',
          style: textStyle.titleSmall!.copyWith(
            fontFamily: FontConstants.fontFamilyCaros,
            color: color.secondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
