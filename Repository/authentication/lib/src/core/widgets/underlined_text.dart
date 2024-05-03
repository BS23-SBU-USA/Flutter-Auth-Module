import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
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
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: 8.h,
          width: 50.w,
          color: color.primary.withOpacity(0.75),
        ),
        Text(
          title,
          style: textStyle.titleMedium,
        ),
      ],
    );
  }
}
