import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPicture extends StatelessWidget {
  final String imagePath;

  const DisplayPicture({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    File photoFile = File(imagePath);
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