import 'package:flutter/material.dart';

import 'package:my_fridge/zones/items/edit_items_form.dart';

import 'package:my_fridge/zones/items/item_class.dart';

class Item extends StatefulWidget {
  final ItemClass item;
  final double itemWidth;
  final Function(ItemClass) onEditItem;

  const Item({
    required this.item,
    required this.itemWidth,
    required this.onEditItem,
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
            child: EditItemsForm(onEditItem: widget.onEditItem, itemEditing: widget.item,),
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
                const Icon(
                  Icons.music_note,
                  size: 60,
                  color: Colors.amber,
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
