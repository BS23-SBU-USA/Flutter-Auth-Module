import 'package:auth_module/src/core/theme/typography/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTitleAndSubtitle extends StatelessWidget {
  const BuildTitleAndSubtitle({
    required this.titleFirstPart,
    required this.titleLastPart,
     this.subtitleFirstPart,
     this.subtitleLastPart,
    super.key,
  });

  final String titleFirstPart;
  final String titleLastPart;
  final String? subtitleFirstPart;
  final String? subtitleLastPart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;
    return Column(
      
      children: [
        TitleHeading(
            titleFirstPart: titleFirstPart, titleLastPart: titleLastPart),
        
        if(subtitleFirstPart != null && subtitleLastPart != null )Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            '$subtitleFirstPart\n$subtitleLastPart',
            style: textStyle.titleSmall!.copyWith(
              fontFamily: FontConstants.fontFamilyCaros,
              color: color.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class TitleHeading extends StatelessWidget {
  const TitleHeading({
    super.key,
    required this.titleFirstPart,
    required this.titleLastPart,
  });

  final String titleFirstPart;

  final String titleLastPart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;
    return Row(
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
    );
  }
}
