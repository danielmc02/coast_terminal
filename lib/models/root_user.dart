

import 'package:hive/hive.dart';
part 'root_user.g.dart';
@HiveType(typeId: 3)
class RootUser extends HiveObject
{
RootUser(this.ccpaCompliant,this.dateDownloaded,this.coins);
  @HiveField(0)
  late bool ccpaCompliant;

  @HiveField(1)
  late String dateDownloaded;

  @HiveField(2)
  late int coins;

}