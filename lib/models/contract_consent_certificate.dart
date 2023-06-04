import 'package:hive/hive.dart';
part 'contract_consent_certificate.g.dart';

@HiveType(typeId: 2)
class ContractConsentCertificate extends HiveObject
{
ContractConsentCertificate(this.ccpaCompliant,this.schoolName);
  @HiveField(0)
  late bool ccpaCompliant;

  @HiveField(1)
  late String schoolName;

}