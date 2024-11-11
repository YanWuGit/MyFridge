import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_fridge/zones/items/input_field.dart';
import 'package:my_fridge/zones/items/item_class.dart';
import 'package:my_fridge/util/error_dialog.dart';
import 'package:my_fridge/util/confirmation_dialog.dart';

import '../../util/camera_utils.dart';
import 'item_icon_selection.dart';

class EditItemsForm extends StatefulWidget {
  final Function(ItemClass) onEditItem;
  final Function(ItemClass) onDeleteItem;
  final ItemClass itemEditing;

  const EditItemsForm(
      {required this.onEditItem,
      required this.onDeleteItem,
      required this.itemEditing,
      super.key});

  @override
  State<EditItemsForm> createState() => _EditItemsFormState();
}

class _EditItemsFormState extends State<EditItemsForm> {
  final _itemNameController = TextEditingController();
  final _itemAmountController = TextEditingController();
  final _daysUntilExpireController = TextEditingController();

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
  void _editItem() {
    String itemName = _itemNameController.text.trim();
    String itemAmount = _itemAmountController.text.trim();
    String daysUntilExpire = _daysUntilExpireController.text.trim();

    // pop up error message if item amount is not a number
    if (itemAmount != '') {
      try {
        int.parse(itemAmount);
      } catch (e) {
        ErrorDialog.showErrorDialog(context, 'Item amount must be a number.');
        return;
      }
    }

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

  void _deleteItem() async {
    bool? deletionConfirm = await ConfirmationDialog.showConfirmationDialog(
        context, 'Delete this item: ${widget.itemEditing.itemName} ?');

    if (deletionConfirm == true) {
      widget.onDeleteItem(widget.itemEditing);

      _itemNameController.clear();
      _itemAmountController.clear();
      _daysUntilExpireController.clear();

      Navigator.of(context).pop();
    }
    return;
  }

  Future<void> _navToTakePicture() async {
    XFile? image = await navToTakePicture(context);
    if (image != null) {
      setState(() {
        widget.itemEditing.imagePath = image.path;
      });
    }
  }

  Future<void> _navToItemIconSelection() async {
    dynamic imageOrIconPath = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ItemIconSelection()));

    // add '0' to the beginning of the path string to indicate it is image path
    // '1' would mean it is icon path
    if (imageOrIconPath[0] == '0') {
      setState(() {
        widget.itemEditing.imagePath = imageOrIconPath.substring(1);
      });
    } else if (imageOrIconPath[0] == '1') {
      setState(() {
        widget.itemEditing.imagePath = '';
        widget.itemEditing.iconPath = imageOrIconPath.substring(1);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 36,
                    ),
                    const Center(
                      child: Text(
                        'Edit Item',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // This button deletes the current item
                    IconButton(
                      onPressed: _deleteItem,
                      icon: const Icon(
                        Icons.delete,
                        size: 36,
                      ),
                      tooltip: 'Delete item',
                    )
                  ],
                )),
            widget.itemEditing.imagePath == ''
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 0.4 * MediaQuery.of(context).size.height,
                    child: Stack(children: [
                      Positioned.fill(
                        child: Image(
                          image: AssetImage(widget.itemEditing.iconPath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          bottom: 8,
                          right: 8,
                          child: IconButton(
                              onPressed: _navToItemIconSelection,
                              icon: const Icon(
                                Icons.sync,
                                size: 60,
                                color: Colors.blueGrey,
                              )))
                    ]),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 0.4 * MediaQuery.of(context).size.height,
                    child: Stack(children: [
                      Positioned.fill(
                        child: Image.file(
                          File(widget.itemEditing.imagePath!),
                          fit: BoxFit.cover,
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
                    child: const Text('Cancel')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _editItem,
                  child: const Text('Update'),
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
