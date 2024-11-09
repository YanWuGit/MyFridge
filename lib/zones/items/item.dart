import 'dart:io';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.itemWidth,
      child: InkWell(
        onTap: _openItemEditing,
        child: Card(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                widget.imagePath == '' ?
                const Icon(
                  Icons.music_note,
                  size: 60,
                  color: Colors.amber,
                )
                : SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.file(File(widget.imagePath!)),
                ),
                Text(widget.item.itemName),
                Text('${widget.item.itemAmount}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
