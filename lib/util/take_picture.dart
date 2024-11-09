import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'display_picture.dart';

class TakePicture extends StatefulWidget {
  final List<CameraDescription> cameras;

  const TakePicture({super.key, required this.cameras});

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription _selectedCamera;

  @override
  void initState() {
    super.initState();

    // Initially select the first camera.
    _selectedCamera = widget.cameras.first;

    // Initialize the camera controller.
    _controller = CameraController(_selectedCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelectCamera(CameraDescription camera) async {
    setState(() {
      _selectedCamera = camera;
      _controller = CameraController(_selectedCamera, ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
        actions: <Widget>[
          PopupMenuButton<CameraDescription>(
            onSelected: _onSelectCamera,
            itemBuilder: (BuildContext context) {
              return widget.cameras.map((CameraDescription camera) {
                return PopupMenuItem<CameraDescription>(
                  value: camera,
                  child: Text(camera.name),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final XFile image = await _controller.takePicture();
            if (!context.mounted) return;

            bool useThisPhoto = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPicture(imagePath: image.path),
              ),
            );
            if (useThisPhoto) {
              Navigator.pop(context, image);
            }
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}