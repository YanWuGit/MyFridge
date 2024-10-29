import 'package:flutter/material.dart';
import 'package:my_fridge/zones/zone.dart';
import 'package:my_fridge/settings.dart';
import 'package:my_fridge/zones/zone_class.dart';
import 'package:my_fridge/zones/items/item_class.dart';
import 'package:my_fridge/zones/items/add_items_form.dart';

class MyFridge extends StatefulWidget {
  const MyFridge({super.key});

  @override
  State<MyFridge> createState() => _MyFridgeState();
}

class _MyFridgeState extends State<MyFridge> {


  List<ItemClass> chillItems = [
    ItemClass('milk', 4),
    ItemClass('bread', 8),
    ItemClass('ham', 12),
  ];

  List<ItemClass> freezeItems = [
    ItemClass('pork', 3),
    ItemClass('beef', 6),
    ItemClass('sausage', 9),
  ];

  late List<ZoneClass> zoneClasses = [
    ZoneClass('Chill Zone', 1, chillItems),
    ZoneClass('Freeze Zone', 1, freezeItems),
  ];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) => Center(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('My Fridge'),
                  centerTitle: true,
                ),
                body: ListView(
                  children: zoneClasses.map((zoneClass) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Zone(zoneName: zoneClass.zoneName, zoneLayers: zoneClass.zoneLayers, items: zoneClass.items),
                          ),
                        );
                      },
                      child: Text(zoneClass.zoneName),
                    );
                  }).toList(),
                ),

                drawer: Drawer(
                  child: ListView(
                    // padding: ,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Text('Menu'),
                      ),
                      ListTile(
                        title: const Text('Settings'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Settings()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}

