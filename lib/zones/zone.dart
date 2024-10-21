import 'package:flutter/material.dart';
import 'package:my_fridge/item.dart';
import '../item_class.dart';

class ChillZone extends StatefulWidget {
  const ChillZone({super.key});

  @override
  State<ChillZone> createState() => _ChillZoneState();
}

class _ChillZoneState extends State<ChillZone> {

  List<ItemClass> items = [
    ItemClass('milk', 4),
    ItemClass('bread', 8),
    ItemClass('ham', 12),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chill Zone'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: items.map((item) => Item(itemName: item.itemName, itemAmount: item.itemAmount)).toList(),
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
