// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInstanceAdapter extends TypeAdapter<UserInstance> {
  @override
  final int typeId = 0;

  @override
  UserInstance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInstance()
      ..uid = fields[0] as String
      ..hasPostedMessage = fields[1] as bool
      ..lastPostedMessageTimestamp = fields[2] as DateTime
      ..createdAt = fields[3] as DateTime
      ..messageInstances = (fields[4] as List?)?.cast<MessageInstance>();
  }

  @override
  void write(BinaryWriter writer, UserInstance obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.hasPostedMessage)
      ..writeByte(2)
      ..write(obj.lastPostedMessageTimestamp)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.messageInstances);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInstanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
