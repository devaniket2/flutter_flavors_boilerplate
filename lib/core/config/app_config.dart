import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_flavors_boilerplate/app/common/constants/api_constants.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum BuildType { qa, production }

/// A class that stores all the data related to app
/// such as version, build number, build type, BASE_URL
class AppConfig extends GetxService {
  late final String appName;
  late final String appVersion;
  late final String appBundleID;
  late final String appBuildNumber;
  late final String apiBaseUrl;
  late final String deviceID;
  late final String deviceType;
  late final String deviceName;
  late final BuildType appBuildType;

  Future<AppConfig> init(BuildType type) async {
    // load values
    final PackageInfo info = await _loadAppInfo();

    appName = info.appName;
    appVersion = info.version;
    appBundleID = info.packageName;
    appBuildNumber = info.buildNumber;
    deviceID = await _getDeviceID();
    deviceType = Platform.operatingSystem;
    deviceName = await _getDeviceName();
    appBuildType = type;
    apiBaseUrl = type == BuildType.production
        ? ApiConstants.BASE_URL_PRODUCTION
        : ApiConstants.BASE_URL_QA;
    return this;
  }

  Future<PackageInfo> _loadAppInfo() async => await PackageInfo.fromPlatform();

  Future<String> _getDeviceID() async {
    // check platform and return appropiate details
    if (Platform.isAndroid) {
      return (await DeviceInfoPlugin().androidInfo).id;
    } else if (Platform.isIOS) {
      return (await DeviceInfoPlugin().iosInfo).identifierForVendor ?? 'Iphone';
    } else {
      return 'unsupported_device_type';
    }
  }

  Future<String> _getDeviceName() async {
    // check platform and return appropiate details
    if (Platform.isAndroid) {
      return (await DeviceInfoPlugin().androidInfo).model;
    } else if (Platform.isIOS) {
      return (await DeviceInfoPlugin().iosInfo).name;
    } else {
      return 'unsupported_device_type';
    }
  }

  Map<String, dynamic> get deviceInfoMap => {
    'device_id': deviceID,
    'device_type': deviceType,
  };
}
