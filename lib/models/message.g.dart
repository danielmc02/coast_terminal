// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageInstanceAdapter extends TypeAdapter<MessageInstance> {
  @override
  final int typeId = 1;

  @override
  MessageInstance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageInstance(
      uidAdmin: fields[0] as String,
      iconIndex: fields[1] as int,
      views: fields[2] as int,
      title: fields[3] as String,
      message: fields[4] as String,
      currentViews: fields[5] as int,
      liked: fields[6] as bool,
      disliked: fields[7] as bool,
      likes: fields[8] as int?,
      dislikes: fields[9] as int?,
      blocks: fields[10] as int,
      tainted: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MessageInstance obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.uidAdmin)
      ..writeByte(1)
      ..write(obj.iconIndex)
      ..writeByte(2)
      ..write(obj.views)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.currentViews)
      ..writeByte(6)
      ..write(obj.liked)
      ..writeByte(7)
      ..write(obj.disliked)
      ..writeByte(8)
      ..write(obj.likes)
      ..writeByte(9)
      ..write(obj.dislikes)
      ..writeByte(10)
      ..write(obj.blocks)
      ..writeByte(11)
      ..write(obj.tainted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageInstanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
