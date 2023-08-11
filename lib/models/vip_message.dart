import 'dart:io';

import 'package:hive/hive.dart';


part 'vip_message.g.dart';
@HiveType(typeId: 4)
class VipMessage extends HiveObject {
  VipMessage(
      {required this.uidAdmin,
      required this.title,
      required this.message,
      required this.image,
      required this.imageUrl,
      required this.url});

  @HiveField(0)
  late String uidAdmin;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String message;
  @HiveField(3)
  late File? image;
  @HiveField(4)
  late String? imageUrl;
  @HiveField(5)
  late String? url;
}
