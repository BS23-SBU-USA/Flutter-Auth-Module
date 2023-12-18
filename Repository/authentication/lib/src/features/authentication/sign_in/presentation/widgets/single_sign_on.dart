part of '../pages/sign_in_page.dart';

class SingleSignOn extends ConsumerStatefulWidget {
  const SingleSignOn({super.key});

  @override
  ConsumerState createState() => _SingleSignOnState();
}

class _SingleSignOnState extends ConsumerState<SingleSignOn> {
  @override
  Widget build(BuildContext context) {
    ref.watch(signInProvider);
    final signInNotifier = ref.read(signInProvider.notifier);
    final ssoSignInNotifier = ref.read(ssoSignInProvider.notifier);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _SocialLogo(url: Assets.facebookLogo),
            SizedBox(width: 20.h),
            _SocialLogo(
              url: Assets.googleLogo,
              onTap: () {
                ssoSignInNotifier.state = true;
                signInNotifier.ssoSignIn(context: context);
              },
            ),
            SizedBox(width: 20.h),
            const _SocialLogo(url: Assets.appleLogo),
          ],
        ),
        SizedBox(height: 30.h),
        Stack(
          alignment: Alignment.center,
          children: [
            const Divider(
              color: UIColors.timberWolf,
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              color: Colors.white,
              child: Text(
                'OR',
                style: AppTypography.medium14Circular(
                  color: UIColors.gray,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
