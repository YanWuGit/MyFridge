import 'package:hive/hive.dart';

part 'item_class.g.dart';

@HiveType(typeId: 0) // Ensure unique typeId for your ItemClass
class ItemClass {
  @HiveField(0)
  String itemName = '';
  @HiveField(1)
  int itemAmount = 0;


  ItemClass(this.itemName, this.itemAmount);
}