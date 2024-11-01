import 'package:hive/hive.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  static Box? _itemDB;

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  Future<void> initialize() async {
    _itemDB = await Hive.openBox('item_db');
  }

  Box get itemDB => _itemDB!;
}