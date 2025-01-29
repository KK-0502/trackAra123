// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memoryModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoryModelAdapter extends TypeAdapter<MemoryModel> {
  @override
  final int typeId = 7;

  @override
  MemoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoryModel(
      titleGet: fields[0] as String,
      dataGet: fields[1] as String,
      imageListGet: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MemoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.titleGet)
      ..writeByte(1)
      ..write(obj.dataGet)
      ..writeByte(2)
      ..write(obj.imageListGet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
