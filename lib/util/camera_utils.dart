import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:my_fridge/util/take_picture.dart';



Future<XFile?> navToTakePicture(BuildContext context) async {
  final cameras = await availableCameras();

  try {
    final XFile? image = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TakePicture(cameras: cameras)),
    );
    return image;
  } catch (e) {
    print("add_items_form: error navigate to camera - $e");
    return null;
  }
}