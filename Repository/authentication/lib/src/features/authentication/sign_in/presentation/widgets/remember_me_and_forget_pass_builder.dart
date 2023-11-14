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
                            return UIColors.pineGreen;
                          }
                          return UIColors.platinum;
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return const BorderSide(
                              color: UIColors.tiffanyBlue,
                            );
                          }
                          return const BorderSide(
                            color: UIColors.pineGreen,
                          );
                        },
                      ),
                      value: state,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: UIColors.pineGreen,
                      checkColor: UIColors.white,
                      onChanged: (value) {
                        notifier.state = value!;
                      },
                    ),
                  ),
                ),
              ),
              Text(
                TextConstants.rememberMe,
                style: AppTypography.medium14Circular(
                  color: UIColors.pineGreen,
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
            style: AppTypography.medium14Circular(
              color: UIColors.pineGreen,
            ),
          ),
        ),
      ],
    );
  }
}
