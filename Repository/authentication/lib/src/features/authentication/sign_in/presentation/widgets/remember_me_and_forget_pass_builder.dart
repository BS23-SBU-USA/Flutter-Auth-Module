part of '../pages/sign_in_page.dart';

class _RememberMeAndForgetPassBuilder extends ConsumerWidget {
  const _RememberMeAndForgetPassBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rememberMeStateProvider);
    final notifier = ref.read(rememberMeStateProvider.notifier);
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            notifier.state = !state;
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 7.w),
                child: SizedBox(
                  height: 16.h,
                  width: 16.h,
                  child: Transform.scale(
                    scale: 0.8.sp,
                    child: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return color.primary;
                          }
                          return color.primaryContainer;
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return BorderSide(
                              color: color.onPrimaryContainer,
                            );
                          }
                          return BorderSide(
                            color: color.primary,
                          );
                        },
                      ),
                      value: state,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      checkColor: color.onPrimary,
                      onChanged: (value) {
                        notifier.state = value!;
                      },
                    ),
                  ),
                ),
              ),
              Text(
                TextConstants.rememberMe,
                style: textStyle.bodySmall!.copyWith(
                  color: color.primary,
                  fontFamily: FontConstants.fontFamilyCaros,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.forgotPassword);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Text(
            TextConstants.forgotPassword,
            style: textStyle.bodySmall!.copyWith(
              color: color.primary,
              fontFamily: FontConstants.fontFamilyCaros,
            ),
          ),
        ),
      ],
    );
  }
}
