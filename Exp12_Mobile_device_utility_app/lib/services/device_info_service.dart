import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, String>> getDeviceInfo() async {
    Map<String, String> deviceData = {};

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceData = {
          'Device Model': androidInfo.model,
          'Manufacturer': androidInfo.manufacturer,
          'Android Version': androidInfo.version.release,
          'SDK Int': androidInfo.version.sdkInt.toString(),
          'Hardware': androidInfo.hardware,
          'Is Physical Device': androidInfo.isPhysicalDevice.toString(),
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceData = {
          'Device Name': iosInfo.name,
          'Model': iosInfo.model,
          'System Name': iosInfo.systemName,
          'System Version': iosInfo.systemVersion,
          'Is Physical Device': iosInfo.isPhysicalDevice.toString(),
        };
      } else {
        deviceData = {'Platform': 'Non-mobile target detected'};
      }
    } catch (e) {
      deviceData = {'Error': e.toString()};
    }

    return deviceData;
  }
}