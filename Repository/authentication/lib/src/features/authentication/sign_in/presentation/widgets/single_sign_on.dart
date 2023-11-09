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
            _buildSocialLogoContainer(Assets.facebookLogo),
            SizedBox(width: 20.h),
            _buildSocialLogoContainer(
              Assets.googleLogo,
            ),
            SizedBox(width: 20.h),
            _buildSocialLogoContainer(Assets.appleLogo),
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
                style: AppTypography.regular14(
                  color: UIColors.gray,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLogoContainer(String url) {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: UIColors.black, // Border color
        ),
      ),
      child: SvgPicture.asset(url),
    );
  }
}
