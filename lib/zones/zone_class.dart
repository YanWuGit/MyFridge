import 'package:my_fridge/zones/items/item_class.dart';

class ZoneClass {

  String zoneName = '';
  int zoneLayers = 1;
  List<ItemClass> items;
  String zoneBGImage = '';
  double zoneNameX = -1;
  double zoneNameY = -1;

  ZoneClass(this.zoneName, this.zoneLayers, this.items, this.zoneBGImage, {this.zoneNameX = -1, this.zoneNameY = -1});

}