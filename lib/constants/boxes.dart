import 'package:coast_terminal/models/contract_consent_certificate.dart';
import 'package:coast_terminal/models/message.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<UserInstance> getuser() => Hive.box<UserInstance>('user');
  static Box<MessageInstance> getMessage() => Hive.box<MessageInstance>('chats');
    static Box<ContractConsentCertificate> getCertificate() => Hive.box<ContractConsentCertificate>('cert');

}
