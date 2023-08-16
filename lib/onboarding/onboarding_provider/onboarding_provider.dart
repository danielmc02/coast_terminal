import 'package:flutter/material.dart';
import 'dart:math';

import '../../constants/boxes.dart';
import '../../models/root_user.dart';
class OnboardingProvider extends ChangeNotifier {
    bool? optInCCPA = true;
late PageController pageController;
  late bool hasCertificate;
 int? index;
 Map? currentMes;
   Map messages = {
    "Message0": {"Title": "Being a broke student", "Message":" Navigating college on a shoestring budget, I innovate frugal adventures while savoring every laughter-filled moments.","Views":"8/10","Likes":"6","Dislikes":"1","Icon":3}
,
    "Message1": {"Title": "I placed 20 dollars on campus", "Message":"Amidst the realm where knowledge thrives, Where eager minds and wisdom connive. On the second floor, a secret concealed, Under a computer, a treasure revealed. Towering walls, a sanctuary so grand, Whispers of stories at your command. Shelves of books, a forest they form, Seek me out, and you'll weather the storm. Where am I found? Can you uncover the clue? Under a computer, in a library true.","Views":"6/10","Likes":"4","Dislikes":"1","Icon":7},

    "Message2": {"Title": "I dont know what to major", "Message":"I have so much going on and can't figure out what to do right now. A lot of people say that majoring in music is fun but I don't know what job you can get with a music degree. I brought the idea to my parents and they said it was a good idea. At this point it seems I'm going to drop out and get into crypto","Views":"6/10","Likes":"4","Dislikes":"0","Icon":7},


  };
OnboardingProvider()
{
       pageController = PageController();

  hasCertificate = false;
  if(Boxes.getRootUser().get('CurrentRootUser') == null)
  {
    print("NO ROOOT USER EXISTS");
    hasCertificate = false;
  }
  else
  {
    hasCertificate = true;
  }
 
  int messageLength = messages.length;
  int randomIndex = Random().nextInt(messageLength);
  print(randomIndex);
      print("Onboarding Provider initialized, size of messages is: ${messages.length}, $messageLength");
      print(messages.values.elementAt(randomIndex));

     currentMes = messages.values.elementAt(randomIndex);
  

//notifyListeners();
}





  String subHeading = "See what fellow students are up to.";
  Color firstCircle = Colors.black;
  Color secondCircle = Colors.grey;
  Color thirdCircle = Colors.grey;

  void changeTitles(int p0) {
    switch (p0) {
      case 2:
        subHeading = "See what fellow students are up to.";
        firstCircle = Colors.black;
        secondCircle = Colors.grey;
        thirdCircle = Colors.grey;

        notifyListeners();
        break;
      case 0:
        subHeading = "Incognito sign ups that expire in 5 minutes";
        firstCircle = Colors.grey;
        secondCircle = Colors.black;
        thirdCircle = Colors.grey;

        notifyListeners();
        break;
      case 1:
        subHeading = "Join our discord to get involved and contribute";
        firstCircle = Colors.grey;
        secondCircle = Colors.grey;
        thirdCircle = Colors.black;

        notifyListeners();
        break;
      default:
        print("hit default for some reason");
        break;
    }
  }

  int currentIndexMessage = 0;
  void switchMessage(int p0) {
    switch (p0) {
      case 2:
      currentIndexMessage = 2;
      notifyListeners();
        break;
      case 1:
      currentIndexMessage = 1;
      notifyListeners();
        break;
      case 0:
      currentIndexMessage = 0;
      notifyListeners();
        break;
    }
  }

   void createRootUser() async{
    print("Opted in for ccpa: $optInCCPA");
    RootUser tU = RootUser(optInCCPA!, DateTime.now().toString(), 50);
    await Boxes.getRootUser().put("CurrentRootUser", tU);
    hasCertificate = true;
    notifyListeners();

  }
  String buttonTitle = "Continue";
  void changeTitle(int i) {
    switch (i) {
      case 0:
        buttonTitle = "Continue";

        notifyListeners();
        break;
      case 1:
        buttonTitle = "Back";
//buttonTitle = "Finish";
        notifyListeners();
        break;

      default:
    }
  }
  bool hasConsented = false;

  void passConsentCorrection(bool value) {
    hasConsented = value;
    notifyListeners();
  }

  String incent = "EULA";
 Future<void> changeUserSight(int i) async {
    switch(i)
    {
      case 0:
      incent = "EULA";
      notifyListeners();
      break;
      case 1:
      incent = "TOS";
      notifyListeners();
      break;
   
      

    }
  }
}
