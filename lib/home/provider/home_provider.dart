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
            print(
              returnedMessage.entries.first.value['Title'],
            );
            MessageInstance currentFetchedMessage = MessageInstance(
                returnedMessage.entries.first.key,
                returnedMessage.entries.first.value['Badge Index'],
                returnedMessage.entries.first.value['Max Views'],
                returnedMessage.entries.first.value['Title'],
                returnedMessage.entries.first.value['Message']);
            Boxes.getMessage().put('currentMessage', currentFetchedMessage);
            fetchedMessage =  currentFetchedMessage;
            print("Going to increment message");
            needsToUpdateRespectedMessage = true;
          });
          //Increment the respected message
        }
        print("bout to return");

        return Transaction.success(
            count); // Leave this because we aren't modyifing count or adding any messages
      });
      print(needsToUpdateRespectedMessage);
      needsToUpdateRespectedMessage == true
          ? await incrementRespectedMessage(globalUid)
          : null;
      /*
      print("done");
      print(Boxes.getMessage().get('currentMessage'));

      print(fetchedMessage);
      */
      print('$fetchedMessage afasfdsf');
      return fetchedMessage;
    } catch (e) {
      print('$e AHHHHHHHH');
    }
    //return true;
  }

  Future incrementRespectedMessage(String Uid) async {
    //Test for 3 cases
    //1. It has never been increased so it's value is 0.1
    //2. It has been increased but isn't maxed so just increment by one
    //3. You are the last (max view), instead of incrementing, just delete it
    final childNode =  ApiService.instance!.messagesDatabase!
        .child(Uid);
    DataSnapshot snapshot = await ApiService.instance!.messagesDatabase!
        .child(Uid)
        .get();
        print(snapshot.value);
        final snap = snapshot.value as Map;
        if(snap['Current Views'] == 0.1)
        {
          print("this is the first view : ${snap['Current Views']}");
          await childNode.child('Current Views').runTransaction((value) {
          return Transaction.success(1);
        } );
        }
        else if(snap['Current Views'] != 0.1 && snap['Current Views'] +1 != snap['Max Views'])
        {
          int curr = snap['Current Views'];
          curr++;
          print('This is the second test case');
             await childNode.child('Current Views').runTransaction((value) {
          return Transaction.success(curr);
        } );
        }
        else if(snap['Current Views'] +1 == snap['Max Views'])
        {
          print("Just delete it, it is the last view");
           await childNode.remove().then((value) async{
          final count = await ApiService.instance!.database!
          .ref('/count')
          .runTransaction((currentCount) {
        int count = currentCount == null ? 0 : currentCount as int;
        print(count);

        print("running transaction");
        return Transaction.success(count - 1);
      });
        });
        
        }/*
    num view;
        snapshot == 0.1 ? view = snapshot.value as double : view = snapshot.value as int;
    int newView = view.round();
    newView++;
    print(newView);
    await ApiService.instance!.messagesDatabase!
        .child(Uid)
        .update({'Current Views': newView});
    print('done');*/
  }
}
