import 'package:flutter/material.dart';
import 'package:my_fridge/zones/items/item.dart';
import 'package:my_fridge/zones/items/item_class.dart';
import 'package:my_fridge/zones/items/add_items_form.dart';

import 'package:my_fridge/hive_service.dart';

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
  final _itemDB = HiveService().itemDB;
  List<ItemClass> displayedItems = [];

  @override
  void initState() {
    super.initState();

    try {
      if (_itemDB.containsKey('chillItems')) {
        final dynamicList = _itemDB.get('chillItems');
        print("Find chillItems in Hive from add_items_form");
        if (dynamicList is List<ItemClass>) {
          displayedItems = dynamicList;
          print("successfully set chillItems to the same as in itemDB");
        } else {

          print("dynamicList is not a list of ItemClass");
        }
      }
    }catch(e) {
      print("Loading item list from Hive failed initializing add_item dialog. $e");
    }

  }

  void _addItem(ItemClass newItem) {
    setState(() {

      try {
        displayedItems.add(newItem);
        _itemDB.put('chillItems', displayedItems);
        print("successfully add newItem into itemDB");
        print(_itemDB.get('chillItems'));
      }catch(e) {
        print("Adding to list in Hive failed. $e");
      }

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
            children: displayedItems.map((item) => Item(itemName: item.itemName, itemAmount: item.itemAmount)).toList(),
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
