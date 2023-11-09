import 'dart:io';

import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  Future<String> getDeviceOS() async {
    if (Platform.isAndroid) {
      return TextConstants.android;
    } else if (Platform.isIOS) {
      return TextConstants.ios;
    } else {
      return TextConstants.unknownDevice;
    }
  }

  Future<String> getDeviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
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
