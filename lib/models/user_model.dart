import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 0)
class UserInstance extends HiveObject
{
  UserInstance( { required this.uid,required this.hasPostedMessage,required this.createdAt,required this.lastPostedMessageTimestamp/*,this.messageInstances*/});

    
  @HiveField(0)
  late String uid;

  @HiveField(1)
  late bool hasPostedMessage;
  
  @HiveField(2)
  late DateTime createdAt;

  @HiveField(3)
  late DateTime? lastPostedMessageTimestamp;

  @HiveField(4)
   List<String> messageUids = [];

/*
  @HiveField(4)
  late List<MessageInstance> messageInstances;
  */
}
