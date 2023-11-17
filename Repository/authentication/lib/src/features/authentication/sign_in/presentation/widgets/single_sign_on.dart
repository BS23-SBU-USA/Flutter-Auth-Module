part of '../pages/sign_in_page.dart';

class SingleSignOn extends StatelessWidget {
  const SingleSignOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialLogoContainer(Assets.facebookLogo, context),
            SizedBox(width: 20.h),
            _buildSocialLogoContainer(Assets.googleLogo, context),
            SizedBox(width: 20.h),
            _buildSocialLogoContainer(Assets.appleLogo, context),
          ],
        ),
        SizedBox(height: 30.h),
        Stack(
          alignment: Alignment.center,
          children: [
            Divider(
              color: context.theme.color.timberWolf,
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              color: Colors.white,
              child: Text(
                'OR',
                style: context.theme.text.medium14Circular
                    .copyWith(color: context.theme.color.gray),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLogoContainer(String url, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.theme.color.black, // Border color
        ),
      ),
      child: SvgPicture.asset(url),
    );
  }
}
