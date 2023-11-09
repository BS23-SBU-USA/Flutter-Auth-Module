import 'package:auth_module/src/core/theme/colors.dart';
import 'package:auth_module/src/core/theme/typography/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
  static TextStyle _getTextStyle(
    double fontSize,
    String fontFamily,
    FontWeight fontWeight,
    Color color,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle regular8({Color? color}) {
    return _getTextStyle(
      FontSize.s8,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular10({Color? color}) {
    return _getTextStyle(
      FontSize.s10,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle light12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontConstants.fontFamily,
      FontWeightManager.light,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontConstants.fontFamily,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold12({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle light14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamily,
      FontWeightManager.light,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamily,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold14({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold15({Color? color}) {
    return _getTextStyle(
      FontSize.s15.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular16({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold16({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontConstants.fontFamily,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold16({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular18({Color? color}) {
    return _getTextStyle(
      FontSize.s18.sp,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold18({Color? color}) {
    return _getTextStyle(
      FontSize.s18.sp,
      FontConstants.fontFamily,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular20({Color? color}) {
    return _getTextStyle(
      FontSize.s20.sp,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold20({Color? color}) {
    return _getTextStyle(
      FontSize.s20.sp,
      FontConstants.fontFamily,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold22({Color? color}) {
    return _getTextStyle(
      FontSize.s22.sp,
      FontConstants.fontFamily,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold18({Color? color}) {
    return _getTextStyle(
      FontSize.s18.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold20({Color? color}) {
    return _getTextStyle(
      FontSize.s20.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold22({Color? color}) {
    return _getTextStyle(
      FontSize.s22.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular24({Color? color}) {
    return _getTextStyle(
      FontSize.s24.sp,
      FontConstants.fontFamily,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold24({Color? color}) {
    return _getTextStyle(
      FontSize.s24.sp,
      FontConstants.fontFamily,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold24({Color? color}) {
    return _getTextStyle(
      FontSize.s24.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold50({Color? color}) {
    return _getTextStyle(
      FontSize.s50.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold36({Color? color}) {
    return _getTextStyle(
      FontSize.s36.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold32({Color? color}) {
    return _getTextStyle(
      FontSize.s32.sp,
      FontConstants.fontFamily,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }
}
