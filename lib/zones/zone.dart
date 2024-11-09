import 'package:flutter/material.dart';
import 'package:my_fridge/zones/items/item.dart';
import 'package:my_fridge/zones/items/item_class.dart';
import 'package:my_fridge/zones/items/add_items_form.dart';

import 'package:my_fridge/hive_service.dart';

class Zone extends StatefulWidget {
  final String zoneName;
  final int zoneLayers;
  final List<ItemClass> items;
  final String bgImagePath;

  const Zone(
      {required this.zoneName,
      required this.zoneLayers,
      required this.items,
      required this.bgImagePath,
      super.key});

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
      if (_itemDB.containsKey(widget.zoneName)) {
        final dynamicList = _itemDB.get(widget.zoneName);
        print("zone: Find ${widget.zoneName} in Hive from zone");
        if (dynamicList is List) {
          displayedItems = dynamicList
              .map((e) {
                if (e is ItemClass) return e;
                return null;
              })
              .whereType<ItemClass>()
              .toList();
        } else {
          print('zone: ${widget.zoneName} is not a list');
        }
      } else {
        print("zone: dynamicList is not a list of ItemClass");
      }
    } catch (e) {
      print(
          "zone: Loading item list from Hive failed initializing add_item dialog. $e");
    }
  }

  void _addItem(ItemClass newItem) {
    setState(() {
      try {
        displayedItems.add(newItem);
        _itemDB.put(widget.zoneName, displayedItems);
        print("zone: successfully add newItem into itemDB");
        print('item id : ${newItem.id}');
        print(_itemDB.get(widget.zoneName));
      } catch (e) {
        print("zone: Adding to list in Hive failed. $e");
      }
    });
  }

  void _editItem(ItemClass editedItem) {
    setState(() {
      try {
        print('edited item id: ${editedItem.id}');
        int index =
            displayedItems.indexWhere((item) => item.id == editedItem.id);
        if (index != -1) {
          displayedItems[index] = editedItem;

          _itemDB.put(widget.zoneName, displayedItems);
          print('zone: Successfully updated edited item in hive.');
        } else {
          print('zone: item to edit not found in list.');
        }
      } catch (e) {
        print('zone: Editing item and store in Hive failed. $e');
      }
    });
  }

  void _deleteItem(ItemClass editedItem) {
    setState(() {
      try {
        print('edited item id: ${editedItem.id}');
        int index =
            displayedItems.indexWhere((item) => item.id == editedItem.id);
        if (index != -1) {
          displayedItems.removeAt(index);

          _itemDB.put(widget.zoneName, displayedItems);
          print('zone: Successfully removed item from hive.');
        } else {
          print('zone: item to delete not found in list.');
        }
      } catch (e) {
        print('zone: Delete item and update Hive failed. $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.zoneName),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.bgImagePath), fit: BoxFit.cover)),
        ),
        Wrap(
          children: displayedItems
              .map((item) => Item(
                    item: item,
                    itemWidth: itemWidth,
                    onEditItem: _editItem,
                    onDeleteItem: _deleteItem,
                    imagePath: item.imagePath,
                  ))
              .toList(),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 40.0,
          ),
          onPressed: () {
            _showAddItemDialog(context);
          }),
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
        });
  }
}
