import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_fridge/zones/items/input_field.dart';
import 'package:my_fridge/zones/items/item_class.dart';

class EditItemsForm extends StatefulWidget {
  final Function(ItemClass) onEditItem;
  final ItemClass itemEditing;

  const EditItemsForm({
  required this.onEditItem,
  required this.itemEditing,
  super.key});

  @override
  State<EditItemsForm> createState() => _EditItemsFormState();
}

class _EditItemsFormState extends State<EditItemsForm> {
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
  void _editItem() {
    String itemName = _itemNameController.text.trim();
    String itemAmount = _itemAmountController.text.trim();
    String daysUntilExpire = _daysUntilExpireController.text.trim();

    // print('Item Name: $itemName');
    // print('Item Amount: $itemAmount');
    // print('Days Until Expire: $daysUntilExpire');

    print(itemName);
    print(itemAmount);
    if (itemName.isNotEmpty) {
      widget.itemEditing.itemName = itemName;
    }
    if (itemAmount.isNotEmpty && int.tryParse(itemAmount) != null) {
      widget.itemEditing.itemAmount = int.parse(itemAmount);
    }
    widget.onEditItem(widget.itemEditing);

    _itemNameController.clear();
    _itemAmountController.clear();
    _daysUntilExpireController.clear();

    Navigator.of(context).pop();
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
                    'Edit Item',
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
            InputField(
              title: 'Item Name',
              isSecured: false,
              controller: _itemNameController,
              hintText: widget.itemEditing.itemName,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              title: 'Item Amount',
              isSecured: false,
              controller: _itemAmountController,
              hintText: '${widget.itemEditing.itemAmount}',
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
                  onPressed: _editItem,
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
