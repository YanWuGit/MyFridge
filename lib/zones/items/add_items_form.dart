import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fridge/util/camera_utils.dart';

import 'package:my_fridge/zones/items/input_field.dart';
import 'package:my_fridge/zones/items/item_class.dart';
import 'package:my_fridge/util/take_picture.dart';
import 'package:my_fridge/util/error_dialog.dart';

class AddItemsForm extends StatefulWidget {
  final Function(ItemClass) onAddItem;

  const AddItemsForm({required this.onAddItem, super.key});

  @override
  State<AddItemsForm> createState() => _AddItemsFormState();
}

class _AddItemsFormState extends State<AddItemsForm> {
  final _itemNameController = TextEditingController();
  final _itemAmountController = TextEditingController();
  final _daysUntilExpireController = TextEditingController();
  XFile? itemImage;
  final double _dialogWidth = Get.width;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemAmountController.dispose();
    _daysUntilExpireController.dispose();
    super.dispose();
  }

  // call this function to add items to database and show on screen
  // rebuild the zone page when this function be called
  void _addItem() {
    int intItemAmount = 0;
    String itemName = _itemNameController.text.trim();
    String itemAmount = _itemAmountController.text.trim();
    String daysUntilExpire = _daysUntilExpireController.text.trim();

    // check item name is not empty
    if (itemName == '') {
      ErrorDialog.showErrorDialog(context, 'Please give the item a name.');
      return;
    }

    // check item amount is an int
    try {
      intItemAmount = int.parse(itemAmount);
    } catch (e) {
      ErrorDialog.showErrorDialog(context, 'Item amount need to be a number.');
      return;
    }

    ItemClass newItem =
        ItemClass(itemName, intItemAmount, imagePath: itemImage?.path);

    widget.onAddItem(newItem);

    _itemNameController.clear();
    _itemAmountController.clear();
    _daysUntilExpireController.clear();

    Navigator.of(context).pop();
  }

  Future<void> _navToTakePicture() async {
    XFile? image = await navToTakePicture(context);
    if (image != null) {
      setState(() {
        itemImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.transparent, width: 0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.blueAccent,
                ),
                width: _dialogWidth,
                child: const Center(
                  child: Text(
                    'Add An Item',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
            if (itemImage == null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _navToTakePicture,
                    child: const Text('Take a photo')),
              )
            else
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 0.4 * MediaQuery.of(context).size.height,
                child: Stack(children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(itemImage!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 8,
                      right: 8,
                      child: IconButton(
                          onPressed: _navToTakePicture,
                          icon: const Icon(
                            Icons.sync,
                            size: 60,
                            color: Colors.blueGrey,
                          )))
                ]),
              ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              title: 'Item Name',
              isSecured: false,
              controller: _itemNameController,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              title: 'Item Amount',
              isSecured: false,
              controller: _itemAmountController,
            ),
            const SizedBox(
              height: 40,
            ),
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
                  onPressed: _addItem,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
