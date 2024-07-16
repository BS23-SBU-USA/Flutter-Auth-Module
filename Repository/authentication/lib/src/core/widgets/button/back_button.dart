import 'package:auth_module/src/core/theme/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../utils/assets.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: SvgPicture.asset(
        Assets.backIcon,
        colorFilter: ColorFilter.mode(
          context.color.onBackground,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}