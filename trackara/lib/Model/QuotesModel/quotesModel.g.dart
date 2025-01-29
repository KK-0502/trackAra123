// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotesModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotesmodelAdapter extends TypeAdapter<Quotesmodel> {
  @override
  final int typeId = 5;

  @override
  Quotesmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quotesmodel(
      image: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Quotesmodel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotesmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
