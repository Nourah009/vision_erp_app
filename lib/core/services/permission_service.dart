import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> requestNotificationPermission() async {
    return await Permission.notification.request();
  }

  Future<bool> isNotificationPermissionGranted() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  Future<bool> isLocationPermissionGranted() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }
}
