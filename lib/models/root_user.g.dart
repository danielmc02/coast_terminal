// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RootUserAdapter extends TypeAdapter<RootUser> {
  @override
  final int typeId = 3;

  @override
  RootUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RootUser(
      fields[0] as bool,
      fields[1] as String,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RootUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.ccpaCompliant)
      ..writeByte(1)
      ..write(obj.dateDownloaded)
      ..writeByte(2)
      ..write(obj.coins);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RootUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
