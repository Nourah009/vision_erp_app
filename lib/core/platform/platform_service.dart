import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

enum AppPlatform {
  Android,
  IOS,
  Windows,
  MacOS,
  Web,
  Unknown,
}

class PlatformService {
  AppPlatform get currentPlatform {
    if (kIsWeb) {
      return AppPlatform.Web;
    } else if (Platform.isAndroid) {
      return AppPlatform.Android;
    } else if (Platform.isIOS) {
      return AppPlatform.IOS;
    } else if (Platform.isWindows) {
      return AppPlatform.Windows;
    } else if (Platform.isMacOS) {
      return AppPlatform.MacOS;
    }
    return AppPlatform.Unknown;
  }
}
