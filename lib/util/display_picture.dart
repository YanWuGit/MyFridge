import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class DisplayPicture extends StatefulWidget {
  final String imagePath;

  const DisplayPicture({super.key, required this.imagePath});

  @override
  State<DisplayPicture> createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {

  late File photoFile;

  @override
  void initState() {
    super.initState();
    photoFile = File(widget.imagePath);
  }

  Future<void> _cropImage() async {
    try {
      CroppedFile? croppedImageFile = await ImageCropper().cropImage(
        sourcePath: photoFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 3),
      );

      if (croppedImageFile != null) {
        setState(() {
          photoFile = File(croppedImageFile.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    File photoFile = File(widget.imagePath);
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Stack(
        children: [
          Image.file(photoFile),
          Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Use Photo'),

                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green,
                  //     foregroundColor: Colors.white,
                  //   ),
                  //   onPressed: _cropImage,
                  //   child: const Text('Crop Photo'),
                  // ),
                ],
              ),
              const SizedBox(height: 40,),
            ],
          ),
        ],
      ),
    );
  }
}