import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fridge/zones/items/input_field.dart';
import 'package:my_fridge/zones/items/item_class.dart';

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

  double _dialogHeight = 0.0;
  double _dialogWidth = Get.width;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _dialogHeight = Get.height / 1.30;
      });
    });
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemAmountController.dispose();
    _daysUntilExpireController.dispose();
    super.dispose();
  }

  void _addItem() {
    String itemName = _itemNameController.text.trim();
    String itemAmount = _itemAmountController.text.trim();
    String daysUntilExpire = _daysUntilExpireController.text.trim();

    // You can now use these variables for whatever you need
    print('Item Name: $itemName');
    print('Item Amount: $itemAmount');
    print('Days Until Expire: $daysUntilExpire');

    ItemClass newItem = ItemClass(itemName, int.parse(itemAmount));
    widget.onAddItem(newItem);

    // Optionally, you can clear the text fields after adding
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
                    'Add A Item',
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
            InputField(
              title: 'Days Until Expire',
              isSecured: false,
              controller: _daysUntilExpireController,
            ),
            Row(
              children: [
                ElevatedButton(onPressed: null, child: Text('Cancel')),
                ElevatedButton(onPressed: _addItem, child: Text('Add')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
