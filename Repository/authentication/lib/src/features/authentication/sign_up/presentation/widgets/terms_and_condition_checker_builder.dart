part of '../pages/sign_up_page.dart';

class TermsAndConditionCheckerBuilder extends ConsumerWidget {
  const TermsAndConditionCheckerBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textStyle = theme.textTheme;
    return GestureDetector(
      onTap: () {
        bool value = !ref.read(termsAndConditionCheckerProvider);
        ref.read(termsAndConditionCheckerProvider.notifier).state = value;
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 7.w),
            child: SizedBox(
              width: 16.h,
              height: 16.h,
              child: Transform.scale(
                scale: 0.8.sp,
                child: TermsCheckbox(color: color),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: TextConstants.iAgreeWith,
              style: textStyle.bodySmall,
              children: <TextSpan>[
                TextSpan(
                  text: TextConstants.termsAndConditions,
                  style: textStyle.bodySmall!.copyWith(
                    color: color.primary,
                    fontFamily: FontConstants.fontFamilyCaros,
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
      ),
    );
  }
}

class TermsCheckbox extends ConsumerWidget {
  const TermsCheckbox({
    super.key,
    required this.color,
  });

  final ColorScheme color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    return Checkbox(
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
      value: ref.watch(termsAndConditionCheckerProvider),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      checkColor: color.onPrimary,
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
      onChanged: (value) {
        ref.read(termsAndConditionCheckerProvider.notifier).state =
            value!;
      },
    );
  }
}
