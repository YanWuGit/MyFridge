// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemClassAdapter extends TypeAdapter<ItemClass> {
  @override
  final int typeId = 0;

  @override
  ItemClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemClass(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ItemClass obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.itemAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
