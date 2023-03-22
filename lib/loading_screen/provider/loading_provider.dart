import 'dart:async';

import 'package:coast_terminal/api_service.dart';
import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  LoadingProvider() {
    _init();
  }

  void _init() async 
  {
    print("Loading provider initialized");
    _startLoading();
  }

  void _startLoading() async
  {
    Timer(Duration(seconds: 2), () async{
      print("Start");
      await ApiService.instance!.signInAnon();
      await ApiService.instance!.fetchMessage();
      print("Finished, spitting out to home");

    },);
  }
}
