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

  Future<MessageInstance?> calculateIfThereAreMessages() async {
    print("this shouldn only print once");
    try {
      MessageInstance? fetchedMessage;
      //step 1: detect if and how many messages exist and plan accordingly via transactions
     await ApiService.instance!.messageCount!.runTransaction((currentCount)  {
        int count = currentCount == null ? 0 : currentCount as int;
        if (count == 0) {
          print("Count is 0, there are no messages");
          fetchedMessage = null;
        } else if (count > 0) {
          print(
              "count is greater than 0, fetching a random message in process");
          //just return the one and only message at messages node index 0
          int randomInt =  Random().nextInt(count);
          final queriedMessage = ApiService.instance!.messagesDatabase!
              .orderByKey()
              .limitToFirst(1)
              .startAt(randomInt.toString())
              .once()
              .then((value) {
            Map returnedMessage = value.snapshot.value as Map;
            print(returnedMessage);
            print(returnedMessage.entries.first.key);
            print(returnedMessage.entries.first.value['Max Views']);
            print(returnedMessage.entries.first.value['Badge Index']);
            print(returnedMessage.entries.first.value['Message']);
            print(returnedMessage.entries.first.value['Title']);
            MessageInstance currentFetchedMessage = MessageInstance(
                returnedMessage.entries.first.key,
                returnedMessage.entries.first.value['Badge Index'],
                returnedMessage.entries.first.value['Max Views'],
                returnedMessage.entries.first.value['Title'],
                returnedMessage.entries.first.value['Message']);
            Boxes.getMessage().put('currentMessage', currentFetchedMessage);
            print(fetchedMessage);
          });
          //  Map returnedMessage = queriedMessage.sna

        }
        print("bout to return");
                  return Transaction.success(count);

      });
      print("done");
                 print(Boxes.getMessage().get('currentMessage'));

      print(fetchedMessage);
      return fetchedMessage;
    } catch (e) {
      print(e);
    }
    //return true;
  }
}
