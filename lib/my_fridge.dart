import 'package:flutter/material.dart';
import 'package:my_fridge/hive_service.dart';
import 'package:my_fridge/zones/zone.dart';
import 'package:my_fridge/settings.dart';
import 'package:my_fridge/zones/zone_class.dart';
import 'package:my_fridge/zones/items/item_class.dart';

class MyFridge extends StatefulWidget {
  const MyFridge({super.key});

  @override
  State<MyFridge> createState() => _MyFridgeState();
}

class _MyFridgeState extends State<MyFridge> {

  final _itemDB = HiveService().itemDB;
  // _itemDB.put(1, 'hi from hive');

  late List<ZoneClass> zoneClasses = [
    ZoneClass('Chill Zone', 1, []),
    ZoneClass('Freeze Zone', 1, []),
  ];

  @override
  void initState() {
    super.initState();
    setupDatabase();
  }

  Future<void> setupDatabase() async {
    for (ZoneClass zone in zoneClasses) {
      List<ItemClass> displayedList = [];
      try{
        if (_itemDB.containsKey(zone.zoneName)) {
          final dynamicList = _itemDB.get(zone.zoneName);
          if (dynamicList is List) {
             displayedList = dynamicList.map((e) {
              if (e is ItemClass) return e;
              return null;
            }).whereType<ItemClass>().toList();
            print('my_fridge: ${zone.zoneName} set successfully');
            print(displayedList);
          } else {
            print('my_fridge: ${zone.zoneName} is not a list');
          }
        } else {
          _itemDB.put(zone.zoneName, displayedList);
          print("my_fridge: ${zone.zoneName} created in Hive");
        }
      } catch (e) {
        print("my_fridge: Error loading data from Hive: $e");
      }
    }
  }


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

