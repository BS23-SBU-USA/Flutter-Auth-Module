part of '../pages/sign_in_page.dart';

class _SocialLogo extends StatelessWidget {
  final String url;
  final Function()? onTap;

  const _SocialLogo({
    required this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: UIColors.black,
          ),
        ),
        child: SvgPicture.asset(url),
      ),
    );
  }
}
