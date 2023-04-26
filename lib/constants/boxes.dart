import 'package:coast_terminal/models/message.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<UserInstance> getuser() => Hive.box<UserInstance>('user');
  static Box<MessageInstance> getMessage() => Hive.box<MessageInstance>('chats');
}
