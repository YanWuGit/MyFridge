import 'package:permission_handler/permission_handler.dart';

Future<void> checkAndRequestPermissions() async {
  PermissionStatus status = await Permission.storage.status;

  if (!status.isGranted) {
    // Request permission
    PermissionStatus newStatus = await Permission.storage.request();
    if (newStatus.isGranted) {
      print('Storage permission granted');
    } else if (newStatus.isDenied || newStatus.isPermanentlyDenied) {
      print('Storage permission denied');
    }
  }
}