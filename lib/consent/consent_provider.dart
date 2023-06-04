
import 'package:coast_terminal/models/contract_consent_certificate.dart';
import 'package:flutter/cupertino.dart';

import '../constants/boxes.dart';

class ConsentProvider extends ChangeNotifier {
  PageController pageController = PageController();
  ConsentProvider();
  bool choseOcc = false;
  bool choseGwc = false;
  bool? optInCCPA = true;
  String school = "";

  String  headerTitle = "What school do you go to?";
  String buttonTitle = "Next";
  void changeTitle(int i)
  {
    switch(i)
    {
      case 0:
      headerTitle = "What school do you go to?";
      buttonTitle = "Next";

      notifyListeners();
      break;
      case 1:
      headerTitle = "Terms of service";
buttonTitle = "Finish";
      notifyListeners();
      break;
      default:
    }
  }
  void chooseSchool(String s) {
    switch (s) {
      case "occ":
        debugPrint("Occ was chosen");
        choseGwc = false;
        choseOcc = true;
        school = "Orange Coast College";
        notifyListeners();
        break;
      case "gwc":
        debugPrint("Gwc was chosen");
        choseOcc = false;
        choseGwc = true;
        school = "Golden West College";
        notifyListeners();
        break;
    }
  }

  Future<void> finishConsent() async{
    print("The user CCPA status is: $optInCCPA , and school is $school");
    final cert = ContractConsentCertificate(optInCCPA!, school);
    if(Boxes.getCertificate().get('currentCert') == null)
    {
      print("No certificates exist, creating new one");
            await Boxes.getCertificate().put('currentCert', cert);

    }
    else
    {
            await Boxes.getCertificate().delete('currentCert');

      await Boxes.getCertificate().put('currentCert', cert);
    }
  }

}
