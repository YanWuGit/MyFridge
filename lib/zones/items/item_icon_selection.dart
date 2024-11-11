import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../util/camera_utils.dart';

// this page is suppose to offer all available icons to be choosen from,
// or let the user navigate to take picture feature.
// upon nav.pop(), this page returns the path of the icon choosen or the image took.
class ItemIconSelection extends StatefulWidget {
  const ItemIconSelection({super.key});

  @override
  State<ItemIconSelection> createState() => _ItemIconSelectionState();
}

class _ItemIconSelectionState extends State<ItemIconSelection> {
  // available icons
  final List<String> iconPaths = [
    'assets/pics/item_icons/item_bakery.jpg',
    'assets/pics/item_icons/item_dairy.jpg',
    'assets/pics/item_icons/item_fruits.jpg',
    'assets/pics/item_icons/item_fruits_1.jpg',
    'assets/pics/item_icons/item_meat.jpg',
    'assets/pics/item_icons/item_seafood.jpg',
  ];

  String? _selectedIconPath;

  void _onIconTap(String iconPath) {
    setState(() {
      // add '0' to the beginning of the path string to indicate it is image path
      // '1' would mean it is icon path
      _selectedIconPath = '1${iconPath}';
    });
    Navigator.pop(context, _selectedIconPath);
  }

  Future<void> _navToTakePicture() async {
    XFile? image = await navToTakePicture(context);
    if (image != null) {
      // add '0' to the beginning of the path string to indicate it is image path
      // '1' would mean it is icon path
      String imagePath = '0${image.path}';
      Navigator.pop(context, imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select An Item Icon'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            ...iconPaths.map((iconPath) {
              bool isSelected = iconPath == _selectedIconPath;

              return GestureDetector(
                onTap: () => _onIconTap(iconPath),
                child: Container(
                  color: isSelected?Colors.blueGrey[100]:null,
                  child: SizedBox(
                    width: 1 / 3 * MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(
                            image: AssetImage(iconPath),
                          )),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.camera_alt,
            size: 40.0,
          ),
          onPressed: _navToTakePicture,
      )
    );
  }
}
