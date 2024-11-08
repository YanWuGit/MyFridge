import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_fridge/zones/items/input_field.dart';
import 'package:my_fridge/zones/items/item_class.dart';

import 'package:my_fridge/util/take_picture.dart';

class AddItemsForm extends StatefulWidget {
  final Function(ItemClass) onAddItem;

  const AddItemsForm({required this.onAddItem, super.key});

  @override
  State<AddItemsForm> createState() => _AddItemsFormState();
}

class _AddItemsFormState extends State<AddItemsForm> {
  List<ItemClass> chillItems = [];

  final _itemNameController = TextEditingController();
  final _itemAmountController = TextEditingController();
  final _daysUntilExpireController = TextEditingController();

  double _dialogWidth = Get.width;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 50), () {
    //   setState(() {
    //    double _dialogHeight = Get.height / 1.30;
    //   });
    // });

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
    String itemName = _itemNameController.text.trim();
    String itemAmount = _itemAmountController.text.trim();
    String daysUntilExpire = _daysUntilExpireController.text.trim();

    // print('Item Name: $itemName');
    // print('Item Amount: $itemAmount');
    // print('Days Until Expire: $daysUntilExpire');

    ItemClass newItem = ItemClass(itemName, int.parse(itemAmount));

    widget.onAddItem(newItem);

    _itemNameController.clear();
    _itemAmountController.clear();
    _daysUntilExpireController.clear();

    Navigator.of(context).pop();
  }

  Future<void> _navToTakePicture() async {
    final cameras = await availableCameras();

    try {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TakePicture(cameras: cameras)),
      );
    } catch (e) {
      print("add_items_form: error navigate to camera - $e");
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: _navToTakePicture,
              child: Text('Take a photo'),
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
              height: 20,
            ),
            // InputField(
            //   title: 'Days Until Expire',
            //   isSecured: false,
            //   controller: _daysUntilExpireController,
            // ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _addItem,
                  child: Text('Add'),
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
