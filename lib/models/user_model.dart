import 'package:coast_terminal/models/message.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 2)
class UserInstance extends HiveObject
{
  UserInstance(this.uid,this.hasPostedMessage,this.createdAt,this.lastPostedMessageTimestamp,this.messageInstances);

    UserInstance.fromJson(Map<String, dynamic> json) {
    uid = json["\$uid"];
    hasPostedMessage = false;
    createdAt = json["creationTime"];
    lastPostedMessageTimestamp = null;
    messageInstances = [];
  }
  @HiveField(0)
  late String uid;

  @HiveField(1)
  late bool hasPostedMessage;
  
  @HiveField(2)
  late DateTime createdAt;

  @HiveField(3)
  late DateTime? lastPostedMessageTimestamp;


  @HiveField(4)
   List<MessageInstance> messageInstances = [];
}
