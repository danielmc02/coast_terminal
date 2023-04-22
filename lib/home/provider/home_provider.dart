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
    print("this should only print once");
    bool needsToUpdateRespectedMessage = false;
    String globalUid = "";
    try {
      MessageInstance? fetchedMessage;
      //step 1: detect if and how many messages exist and plan accordingly via transactions
      await ApiService.instance!.messageCount!.runTransaction((currentCount) {
        int count = currentCount == null ? 0 : currentCount as int;
        print('The mutable current count is $count');
        if (count == 0) {
          print("Count is 0, there are no messages");
          fetchedMessage = null;
          return Transaction.success(0);
        } else if (count > 0) {
          print(
              "count is greater than 0, fetching a random message in process");
          //just return the one and only message at messages node index 0
          int randomInt = Random().nextInt(count);
          print("fetching at index $randomInt");
          final queriedMessage = ApiService.instance!.messagesDatabase!
              .orderByKey()
              .limitToFirst(1)
              .startAt(randomInt.toString())
              .once()
              .then((value) {
            Map returnedMessage = value.snapshot.value as Map;
            globalUid = returnedMessage.entries.first.key;
/*
            if (globalUid ==  Boxes.getuser().get('mainUser')!.uid.toString()) {
              fetchedMessage = null;
              return Transaction.abort();
            }*/
            MessageInstance currentFetchedMessage = MessageInstance(
                returnedMessage.entries.first.key,
                returnedMessage.entries.first.value['Badge Index'],
                returnedMessage.entries.first.value['Max Views'],
                returnedMessage.entries.first.value['Title'],
                returnedMessage.entries.first.value['Message']);
            Boxes.getMessage().put('currentMessage', currentFetchedMessage);
            fetchedMessage = currentFetchedMessage;
            print("Going to increment message");
            needsToUpdateRespectedMessage = true;
          });
          //Increment the respected message
        }
        print("bout to return");

        return Transaction.success(
            count); // Leave this because we aren't modyifing count or adding any messages
      });
      needsToUpdateRespectedMessage == true
          ? incrementRespectedMessage(globalUid)
          : null;
      /*
      print("done");
      print(Boxes.getMessage().get('currentMessage'));

      print(fetchedMessage);
      */
      return fetchedMessage;
    } catch (e) {
      print('$e AHHHHHHHH');
    }
    //return true;
  }

  Future incrementRespectedMessage(String Uid) async {
    DataSnapshot snapshot = await ApiService.instance!.messagesDatabase!
        .child(Uid)
        .child('Current Views')
        .get();
    var view =
        snapshot == 0.1 ? snapshot.value as double : snapshot.value as int;
    int newView = view.round();
    newView++;
    print(newView);
    await ApiService.instance!.messagesDatabase!
        .child(Uid)
        .update({'Current Views': newView});
    print('done');
  }
}
