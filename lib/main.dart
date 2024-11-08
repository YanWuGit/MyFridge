import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_fridge/hive_service.dart';
import 'package:my_fridge/zones/items/item_class.dart';
import 'my_fridge.dart';
import 'package:my_fridge/util/permissions.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  checkAndRequestPermissions();
  await Hive.initFlutter();

  Hive.registerAdapter(ItemClassAdapter());

  await HiveService().initialize();


  runApp(GetMaterialApp(
    home: MyFridge(),
  ) );
}

