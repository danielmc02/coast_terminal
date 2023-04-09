import 'dart:html';
import 'package:coast_terminal/models/message.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 0)
class UserInstance extends HiveObject
{
  @HiveField(0)
  late String uid;

  @HiveField(1)
  late bool hasPostedMessage;
  
  @HiveField(2)
  late DateTime lastPostedMessageTimestamp;

  @HiveField(3)
  late DateTime createdAt;

  @HiveField(4)
  late List<MessageInstance>? messageInstances;
}