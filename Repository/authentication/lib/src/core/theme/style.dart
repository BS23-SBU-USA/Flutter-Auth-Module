// ignore_for_file: library_private_types_in_public_api

import 'package:auth_module/src/core/theme/colors.dart';
import 'package:auth_module/src/core/theme/fonts.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:flutter/material.dart';

@immutable
class AppStyle {
  AppStyle({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
      return;
    }
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;
    if (shortestSide > tabletXl) {
      scale = 1.75;
    } else if (shortestSide > tabletLg) {
      scale = 1.5;
    } else if (shortestSide > tabletSm) {
      scale = 1.25;
    } else if (shortestSide > phoneLg) {
      scale = 1;
    } else {
      scale = .85;
    }

    Log.debug('screenSize=$screenSize, scale=$scale');
  }

  late final double scale;
  final AppColor color = AppColor();
  late final _Text text = _Text(scale);
}

@immutable
class _Text {
  _Text(this._scale);

  final double _scale;

  final TextStyle _caros =
      const TextStyle(fontFamily: FontConstants.fontFamilyCaros);
  final TextStyle _circular =
      const TextStyle(fontFamily: FontConstants.fontFamilyCircular);

  TextStyle get caros => _caros;

  TextStyle get circular => _circular;

  late final TextStyle regular12Caros = _createFont(
    caros,
    sizePx: 12,
    heightPx: 14,
    weight: FontWeightManager.regular,
  );

  late final TextStyle bold12Caros = _createFont(
    caros,
    sizePx: 12,
    heightPx: 14,
    weight: FontWeightManager.bold,
  );

  late final TextStyle regular14Caros = _createFont(
    caros,
    sizePx: 14,
    heightPx: 14,
    weight: FontWeightManager.regular,
  );

  late final TextStyle semiBold14Circular = _createFont(
    circular,
    sizePx: 14,
    heightPx: 14,
    weight: FontWeightManager.semiBold,
  );

  late final TextStyle semiBold14Caros = _createFont(
    caros,
    sizePx: 14,
    heightPx: 14,
    weight: FontWeightManager.semiBold,
  );

  late final TextStyle bold14Caros = _createFont(
    caros,
    sizePx: 14,
    heightPx: 14,
    weight: FontWeightManager.bold,
  );

  late final TextStyle regular16Caros = _createFont(
    caros,
    sizePx: 16,
    heightPx: 16,
    weight: FontWeightManager.regular,
  );

  late final TextStyle medium16Caros = _createFont(
    caros,
    sizePx: 16,
    heightPx: 16,
    weight: FontWeightManager.regular,
  );

  late final TextStyle semiBold16Caros = _createFont(
    caros,
    sizePx: 16,
    heightPx: 16,
    weight: FontWeightManager.semiBold,
  );

  late final TextStyle semiBold18Caros = _createFont(
    caros,
    sizePx: 18,
    heightPx: 18,
    weight: FontWeightManager.semiBold,
  );

  late final TextStyle bold24Caros = _createFont(
    caros,
    sizePx: 24,
    heightPx: 24,
    weight: FontWeightManager.bold,
  );

  late final TextStyle regular14Circular = _createFont(
    circular,
    sizePx: 14,
    heightPx: 16,
    weight: FontWeightManager.regular,
  );

  late final TextStyle medium14Circular = _createFont(
    circular,
    sizePx: 14,
    heightPx: 14,
    weight: FontWeightManager.medium,
  );

  TextStyle _createFont(
    TextStyle style, {
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    FontWeight? weight,
  }) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }
    return style.copyWith(
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : style.height,
      letterSpacing:
          spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
      fontWeight: weight,
    );
  }
}
