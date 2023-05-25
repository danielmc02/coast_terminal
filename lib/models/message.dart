import 'package:hive/hive.dart';
part 'message.g.dart';

@HiveType(typeId: 1)
class MessageInstance extends HiveObject
{
  MessageInstance(this.uidAdmin,this.iconIndex,this.views,this.title,this.message,this.currentViews);
  @HiveField(0)
  late String uidAdmin;

  @HiveField(1)
  late int iconIndex;
  
  @HiveField(2)
  late int views;

  @HiveField(3)
  late String title;

  @HiveField(4)
  late String message;

  @HiveField(5)
  late int currentViews;
}