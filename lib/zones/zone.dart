import 'package:flutter/material.dart';
import 'package:my_fridge/item.dart';
import '../item_class.dart';

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
        onPressed: () {},
      ),
    );
  }
}
