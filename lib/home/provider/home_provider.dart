import 'dart:math';

import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/models/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../constants/boxes.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    _init();
  }
  _init() async {}

  Future<Text> fetchMessageIfExists() async {
    try {
      MessageInstance? currentFetchedMessage;
      DatabaseReference? messageDBref = ApiService.instance!.messagesDatabase;

      //Run a transaction to get the current count
      await ApiService.instance!.messageCount!.runTransaction((currentCount) {
        int count = currentCount == null ? 0 : currentCount as int;
        print("THE COUNT IS $count");
        return Transaction.success(count);
      }).then(
        (value) async // Transactions may run more than once to confirm the actual value, use the then function to run the final value
        {
          int returnedCountValue = await value.snapshot.value
              as int; //The current messages count (instances)
          print('The final ran value is $returnedCountValue');
          if (returnedCountValue >
              0) //return a  messageInstance since there is something, the future builder will display it as long as snapshot isn't null
          {
          await returnRandomMessageKey();

          }
        },
      );
      return Text('hiii');
    } catch (e) {
      print('error in step 1: $e');
      return Text('ahh');
    }
  }

  Future<String> returnRandomMessageKey() async{
    DatabaseReference? keysRef = ApiService.instance!.keys;
      List<String> allKeys = [];
String key = '';
    keysRef!.once().then((value) async {

      final MapResults = value.snapshot.value as Map;
      MapResults.forEach(
        (key, value) {
          print(key);
          allKeys.add(key);
        },
      );
                int randomIndex = Random().nextInt(allKeys.length);

      print('$allKeys\nLength: ${allKeys.length}\nRandom IndexFetched: ${allKeys[randomIndex]} ');
      
    });
          int randomIndex = Random().nextInt(allKeys.length);

          return allKeys[randomIndex];

  }
}
