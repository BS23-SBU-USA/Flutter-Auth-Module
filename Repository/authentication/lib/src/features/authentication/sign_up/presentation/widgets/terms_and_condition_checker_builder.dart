part of '../pages/sign_up_page.dart';

class TermsAndConditionCheckerBuilder extends ConsumerWidget {
  const TermsAndConditionCheckerBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 7.w),
          child: SizedBox(
            width: 16.h,
            height: 16.h,
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
                value: ref.watch(termsAndConditionCheckerProvider),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: UIColors.secondary,
                checkColor: UIColors.primary,
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
                onChanged: (value) {
                  ref.read(termsAndConditionCheckerProvider.notifier).state =
                      value!;
                },
              ),
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            text: TextConstants.iAgreeWith,
            style: AppTypography.semiBold14(),
            children: <TextSpan>[
              TextSpan(
                text: TextConstants.termsAndConditions,
                style: AppTypography.semiBold14(
                  color: UIColors.secondary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(
                      context,
                      Routes.webView,
                      arguments: 'https://www.flutter.dev',
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
