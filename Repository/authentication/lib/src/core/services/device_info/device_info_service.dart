import 'dart:io';

import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfoService {
  Future<String> getDeviceOS() async {
    if (kIsWeb) {
      return TextConstants.android;
    } else if (Platform.isAndroid) {
      return TextConstants.android;
    } else if (Platform.isIOS) {
      return TextConstants.ios;
    } else {
      return TextConstants.unknownDevice;
    }
  }

  Future<String> getDeviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      return TextConstants.unknownDevice;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    } else {
      return TextConstants.unknownDevice;
    }
  }
}
