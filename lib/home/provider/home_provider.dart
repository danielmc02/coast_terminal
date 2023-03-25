import 'package:coast_terminal/api_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    _init();
  }
  _init() async
  {
    
  }

  Future<bool> calculate() async {
    DataSnapshot snapshot = await ApiService.instance!.getMessageCount();
    if (snapshot.exists) {
      int num = snapshot.value as int;
      if (num >= 1) {
        return true;
      } else if (num <= 0) {
        return false;
      }
    } else {
      print('snapshot does not exist, returning false');
      return false;
    }
    return false;
  }
}
