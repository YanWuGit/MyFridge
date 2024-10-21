import 'package:flutter/material.dart';
import 'package:my_fridge/zones/zone.dart';
import 'package:my_fridge/settings.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({super.key});

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
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChillZone(),
                          ),
                        );
                      },
                      child: const Text('Chill Zone'),
                    ),
                  ],
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
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    print('pressed!');
                  },
                ),
              )),
        ));
  }
}
