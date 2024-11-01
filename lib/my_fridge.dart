import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_fridge/hive_service.dart';
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

  final _itemDB = HiveService().itemDB;
  // _itemDB.put(1, 'hi from hive');

  List<ItemClass> chillItems = [];

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
  void initState() {
    super.initState();
    setupDatabase();
  }

  Future<void> setupDatabase() async {
    try{
      if (_itemDB.containsKey('chillItems')) {
        final dynamicList = _itemDB.get('chillItems');
        if (dynamicList is List<ItemClass>) {
          chillItems = dynamicList;
        } else {
          print("stored list is not List<ItemClass>");
        }
        print("ChillItems exists in Hive");
      } else {
        _itemDB.put('chillItems', chillItems);
        print("chillItems created in Hive");
      }
    } catch (e) {
      print("Error loading data from Hive: $e");
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

