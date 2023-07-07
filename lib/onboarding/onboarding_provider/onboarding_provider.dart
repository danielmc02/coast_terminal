import 'package:flutter/material.dart';
import 'dart:math';
class OnboardingProvider extends ChangeNotifier {
 int? index;
 Map? currentMes;
   Map messages = {
    "Message0": {"Title": "How do you feel about marijuana?", "Message":"I feel some of you guys should really try marijuanna. I sometimes will see a student look like they're ready to die.","Views":"8/10","Likes":"6","Dislikes":"1","Icon":3}
,
    "Message1": {"Title": "I placed 20 dollars on campus", "Message":"Amidst the realm where knowledge thrives, Where eager minds and wisdom connive. On the second floor, a secret concealed, Under a computer, a treasure revealed. Towering walls, a sanctuary so grand, Whispers of stories at your command. Shelves of books, a forest they form, Seek me out, and you'll weather the storm. Where am I found? Can you uncover the clue? Under a computer, in a library true.","Views":"6/10","Likes":"4","Dislikes":"1","Icon":7},

    "Message2": {"Title": "I could use help with this app", "Message":"If you want to contribute to the development of the app join the discord","Views":"6/10","Likes":"4","Dislikes":"0","Icon":7},


  };
OnboardingProvider()
{
  int messageLength = messages.length;
  int randomIndex = Random().nextInt(messageLength);
  print(randomIndex);
      print("Onboarding Provider initialized, size of messages is: ${messages.length}, $messageLength");
      print(messages.values.elementAt(randomIndex));

     currentMes = messages.values.elementAt(randomIndex);
notifyListeners();
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
        subHeading = "Incognito sign ups that expire in 12 hour";
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
}
