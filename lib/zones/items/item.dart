import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_fridge/util/error_dialog.dart';

import 'package:my_fridge/zones/items/edit_items_form.dart';

import 'package:my_fridge/zones/items/item_class.dart';

class Item extends StatefulWidget {
  final ItemClass item;
  final double itemWidth;
  final String? imagePath;
  final Function(ItemClass) onEditItem;
  final Function(ItemClass) onDeleteItem;

  const Item({
    required this.item,
    required this.itemWidth,
    required this.onEditItem,
    required this.onDeleteItem,
    this.imagePath,
    super.key
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {

  // opens item editing dialog upon clicking item card
  void _openItemEditing() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: EditItemsForm(onEditItem: widget.onEditItem, itemEditing: widget.item, onDeleteItem: widget.onDeleteItem,),
          );
        });
  }

  void _addItemAmount () {
    setState(() {
      widget.item.itemAmount ++;
    });
    // save edited item in hive
    widget.onEditItem(widget.item);
  }

  void _reduceItemAmount () {
    setState(() {
      if (widget.item.itemAmount > 0) {
        widget.item.itemAmount --;
        // save edited item in hive
        widget.onEditItem(widget.item);
      } else {
        ErrorDialog.showErrorDialog(context, 'Item amount cannot be further reduced.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = widget.itemWidth;

    return SizedBox(
      width: cardWidth,
      child: InkWell(
        onTap: _openItemEditing,
        child: Card(
          color: Colors.greenAccent.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: widget.itemWidth,
                  height: 1.3 * widget.itemWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: widget.imagePath == ''?
                        const Image(
                          image: AssetImage('assets/pics/lunch-box-1141196_640.jpg'),
                          fit: BoxFit.cover,
                        )
                        :Image.file(
                        File(
                            widget.imagePath!
                        ),
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                    widget.item.itemName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                    '${widget.item.itemAmount}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: _reduceItemAmount,
                        icon: Icon(
                            Icons.remove_circle_outline,
                          size: 0.25 * cardWidth,
                        )
                    ),
                    IconButton(
                        onPressed: _addItemAmount,
                        icon: Icon(
                            Icons.add_circle_outline,
                            size: 0.25 * cardWidth,
                        ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
