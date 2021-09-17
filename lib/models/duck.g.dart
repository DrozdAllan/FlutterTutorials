// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duck.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DuckAdapter extends TypeAdapter<Duck> {
  @override
  final int typeId = 0;

  @override
  Duck read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Duck(
      fields[0] as int,
      fields[1] as String,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Duck obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isExtinct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DuckAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
