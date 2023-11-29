// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_recipes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyRecipesAdapter extends TypeAdapter<RecentlyRecipes> {
  @override
  final int typeId = 0;

  @override
  RecentlyRecipes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyRecipes()
      ..recentlyID = fields[0] as int
      ..recentlyPhoto = fields[1] as String
      ..recentlyName = fields[2] as String
      ..recentlyReadyTime = fields[3] as String
      ..recentlyScore = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, RecentlyRecipes obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.recentlyID)
      ..writeByte(1)
      ..write(obj.recentlyPhoto)
      ..writeByte(2)
      ..write(obj.recentlyName)
      ..writeByte(3)
      ..write(obj.recentlyReadyTime)
      ..writeByte(4)
      ..write(obj.recentlyScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyRecipesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
