part of '../pages/sign_in_page.dart';

class _RememberMeAndForgetPassBuilder extends ConsumerWidget {
  const _RememberMeAndForgetPassBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rememberMeStateProvider);
    final notifier = ref.read(rememberMeStateProvider.notifier);

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
                            return UIColors.secondary;
                          }
                          return UIColors.grey20;
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return const BorderSide(
                              color: UIColors.lightTeal,
                            );
                          }
                          return const BorderSide(
                            color: UIColors.secondary,
                          );
                        },
                      ),
                      value: state,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: UIColors.secondary,
                      checkColor: UIColors.primary,
                      onChanged: (value) {
                        notifier.state = value!;
                      },
                    ),
                  ),
                ),
              ),
              Text(
                TextConstants.rememberMe,
                style: AppTypography.semiBold14(
                  color: UIColors.secondary,
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
            style: AppTypography.semiBold14(
              color: UIColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
