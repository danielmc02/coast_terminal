// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip_message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VipMessageAdapter extends TypeAdapter<VipMessage> {
  @override
  final int typeId = 4;

  @override
  VipMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VipMessage(
      uidAdmin: fields[0] as String,
      title: fields[1] as String,
      message: fields[2] as String,
      image: fields[3] as File?,
      imageUrl: fields[4] as String?,
      url: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VipMessage obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uidAdmin)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VipMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
