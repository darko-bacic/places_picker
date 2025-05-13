import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceDetector {
  static Future<bool> isHuaweiDevice() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.manufacturer.toLowerCase().contains('huawei') || androidInfo.brand.toLowerCase() == 'huawei';
    }
    return false;
  }
}
