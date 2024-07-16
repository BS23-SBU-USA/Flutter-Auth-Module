import 'package:auth_module/src/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<ModalCard> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet<void>(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(24).copyWith(
                right: 0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _ModalHeader(title: title),
                  ...children,
                ],
              ),
            );
          },
        );
      },
      child: Image.asset(
        Assets.expandIcon,
        width: 24.sp,
        height: 24.sp,
        color: color.primary,
      ),
    );
  }
}

class ModalCard extends StatelessWidget {
  const ModalCard({
    required this.onTap,
    required this.icon,
    required this.label,
    super.key,
  });

  final VoidCallback? onTap;
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 64.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: color.primaryContainer,
                child: Image.asset(
                  icon,
                  color: color.onPrimaryContainer,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: color.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: text.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, right: 24.w, left: 24.w),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: text.titleMedium,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SvgPicture.asset(
                Assets.remove,
                width: 24.sp,
                height: 24.sp,
                colorFilter: ColorFilter.mode(
                  color.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
