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

  static final Uuid _uuid = Uuid();

  ItemClass(this.itemName, this.itemAmount, {String? imagePath}):id = _uuid.v4(), imagePath = imagePath??'';

  ItemClass.withId(this.itemName, this.itemAmount, this.id, {String? imagePath}): imagePath = imagePath??'';

}