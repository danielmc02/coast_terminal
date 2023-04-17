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
  _init() async
  {
    
  }

  Future calculateIfThereAreMessages() async {
    try
    {
      //step 1: detect if and how many messages exist and plan accordingly via transactions
   
    int snapshot = await ApiService.instance!.getMessageCount();
    if(snapshot > 1)
    {
      print('snapshot is greater than 0. This means there is message(s)');
      /*
int randomIntRange = (Random().nextDouble() * snapshot).floor();
      print("Random intrange generated number is: $randomIntRange");
            final query =  ApiService.instance!.messagesDatabase!.orderByKey().limitToFirst(0).startAt('$randomIntRange');
      final messageSnapshot = await query.once();
      messageSnapshot == null ? print("message snapshot null") : print("snapshot isnt null");
      Map returnedMessage = messageSnapshot.snapshot.value as Map;

      print(returnedMessage);
      print(returnedMessage.entries.first.key);
      print(returnedMessage.entries.first.value['Max Views']);
      print(returnedMessage.entries.first.value['Badge Index']);
      print(returnedMessage.entries.first.value['Message']);
      print(returnedMessage.entries.first.value['Title']);


      
      MessageInstance currentFetchedMessage = MessageInstance(returnedMessage.entries.first.key,returnedMessage.entries.first.value['Badge Index'],returnedMessage.entries.first.value['Max Views'],returnedMessage.entries.first.value['Title'],returnedMessage.entries.first.value['Message']);
      Boxes.getMessage().put('currentMessage', currentFetchedMessage);
      */
      //query a message 
    }
    else if(snapshot == 1)
    {
      int indexOfFirstMessage = 0;
      print('Snapshot claims therer is only 1 message, so I will retrieve the first message (at the zero index)');
      print('The random int generated is 0 and always will be zero');
      final query =  ApiService.instance!.messagesDatabase!.orderByKey().limitToFirst(1).startAt('$indexOfFirstMessage');
      final messageSnapshot = await query.once();
      messageSnapshot == null ? print("message snapshot null") : print("snapshot isnt null");
      Map returnedMessage = messageSnapshot.snapshot.value as Map;
/*
      print(returnedMessage);
      print(returnedMessage.entries.first.key);
      print(returnedMessage.entries.first.value['Max Views']);
      print(returnedMessage.entries.first.value['Badge Index']);
      print(returnedMessage.entries.first.value['Message']);
      print(returnedMessage.entries.first.value['Title']);
*/

      
      MessageInstance currentFetchedMessage = MessageInstance(returnedMessage.entries.first.key,returnedMessage.entries.first.value['Badge Index'],returnedMessage.entries.first.value['Max Views'],returnedMessage.entries.first.value['Title'],returnedMessage.entries.first.value['Message']);
      Boxes.getMessage().put('currentMessage', currentFetchedMessage);

    }
    else
    {
      print("There are 0 messages");
    }


    }
    catch(e)
    {
      print(e);
    }
  //  print("The number of messages in the db is: $snapshot");
   return true;
  }
}
