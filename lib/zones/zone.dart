import 'package:flutter/material.dart';
import 'package:my_fridge/zones/items/item.dart';
import 'package:my_fridge/zones/items/item_class.dart';
import 'package:my_fridge/zones/items/add_items_form.dart';

class Zone extends StatefulWidget {

  final String zoneName;
  final int zoneLayers;
  final List<ItemClass> items;
  
  const Zone({
    required this.zoneName,
    required this.zoneLayers,
    required this.items,
    super.key
  });

  @override
  State<Zone> createState() => _ZoneState();
}

class _ZoneState extends State<Zone> {

  late List<ItemClass> displayedItems;

  @override
  void initState() {
    super.initState();
    displayedItems = widget.items; // Copy initial items for display
  }

  void _addItem(ItemClass newItem) {
    setState(() {
      displayedItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.zoneName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: widget.items.map((item) => Item(itemName: item.itemName, itemAmount: item.itemAmount)).toList(),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 40.0,
        ),
        onPressed: (){_showAddItemDialog(context);}
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: AddItemsForm(onAddItem: _addItem),
          );
        }
    );
  }
}
