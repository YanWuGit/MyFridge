import 'dart:io';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'item_class.g.dart';

@HiveType(typeId: 0) // Ensure unique typeId for your ItemClass
class ItemClass {
  @HiveField(0)
  String itemName = '';
  @HiveField(1)
  int itemAmount = 0;
  @HiveField(2)
  String id;
  @HiveField(3)
  String? imagePath;
  @HiveField(4)
  String? iconPath;

  static final Uuid _uuid = Uuid();

  ItemClass(this.itemName, this.itemAmount, {String? imagePath, String? iconPath}):id = _uuid.v4(), imagePath = imagePath??'', iconPath = iconPath??'';

  ItemClass.withId(this.itemName, this.itemAmount, this.id, {String? imagePath, String? iconPath}): imagePath = imagePath??'', iconPath = imagePath??'';

}