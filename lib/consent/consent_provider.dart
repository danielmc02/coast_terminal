import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';

class ConsentProvider extends ChangeNotifier {
  PageController pageController = PageController();
  ConsentProvider() {}
  bool choseOcc = false;
  bool choseGwc = false;
  void chooseSchool(String s) {
    switch (s) {
      case "occ":
        debugPrint("Occ was chosen");
        choseGwc = false;
        choseOcc = true;
        notifyListeners();
        break;
      case "gwc":
        debugPrint("Gwc was chosen");
        choseOcc = false;
        choseGwc = true;
        notifyListeners();
        break;
    }
  }

}
