import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/boxes.dart';

class PostProvider extends ChangeNotifier {
  bool drawerIsOpen = false;
  Map<String, Map> badges = <String, Map>{
    'Anonymous': {
      'icon': Image.asset('assets/face_icons/anonymous.png'),
      'selected': true
    },
    'Occ': {
      'icon': Image.asset('assets/face_icons/occ.jpeg'),
      'selected': false
    },
    'Angel': {
      'icon': Image.asset('assets/face_icons/angel.png'),
      'selected': false
    },
    'Angry': {
      'icon': Image.asset('assets/face_icons/angry.png'),
      'selected': false
    },
    'Cool': {
      'icon': Image.asset('assets/face_icons/cool.png'),
      'selected': false
    },
    'Cry': {
      'icon': Image.asset('assets/face_icons/cry.png'),
      'selected': false
    },
    'Dead': {
      'icon': Image.asset('assets/face_icons/dead.png'),
      'selected': false
    },
    'Demon': {
      'icon': Image.asset('assets/face_icons/demon.png'),
      'selected': false
    },
    'Disappointed': {
      'icon': Image.asset('assets/face_icons/disappointed.png'),
      'selected': false
    },
    'Exhale': {
      'icon': Image.asset('assets/face_icons/exhale.png'),
      'selected': false
    },
    'Frustrated': {
      'icon': Image.asset('assets/face_icons/frustrated.png'),
      'selected': false
    },
    'Happy': {
      'icon': Image.asset('assets/face_icons/happy.png'),
      'selected': false
    },
    'Hide': {
      'icon': Image.asset('assets/face_icons/hide.png'),
      'selected': false
    },
    'Love': {
      'icon': Image.asset('assets/face_icons/love.png'),
      'selected': false
    },
    'Mask': {
      'icon': Image.asset('assets/face_icons/mask.png'),
      'selected': false
    },
    'Neutral': {
      'icon': Image.asset('assets/face_icons/neutral.png'),
      'selected': false
    },
    'Scared': {
      'icon': Image.asset('assets/face_icons/scared.png'),
      'selected': false
    },
    'Shock': {
      'icon': Image.asset('assets/face_icons/shock.png'),
      'selected': false
    },
    'Sus': {
      'icon': Image.asset('assets/face_icons/sus.png'),
      'selected': false
    },
    //'Unmasked': {'icon': Image.asset('assets/face_icons/unmasked.png')},
  };
  Image chosen = Image.asset('assets/face_icons/anonymous.png');
  int chosenBadgeIndex = 0;

  void updateBadges(int index) {
    int num = 0;

    for (var e in badges.entries) {
      if (num == index) {
        e.value['selected'] = true;
        chosen = e.value['icon'];
        chosenBadgeIndex = num;
        print(chosenBadgeIndex);

        notifyListeners();
      } else {
        e.value['selected'] = false;
        notifyListeners();
      }
      print("$num vs $index");
      num++;
    }
  }

//Update this method later to checking the db for the uid to make sure no update or exisitn data from the user exeists
//I relized an exploit is that when there are updates the counter still increments
//Despite updates not being a new message
//Solved: This new implementaion works around this because we will be fetching a list of keys, I will then narrow and filter what uid I will pick

  Future<bool> postMessage(
      int sliderValue, String title, String message) async {
    bool result = false;
    try {
      await ApiService.instance!.messagesDatabase!
          .child(ApiService.instance!.auth!.currentUser!.uid)
          .set({
        "Badge Index": chosenBadgeIndex,
        "Current Views": 0.1,
        "Max Views": sliderValue,
        "Title": title.toString(),
        "Message": message.toString(),
      //  "Likes" : 0.1,
      //  "Dislikes" : 0.1
      }).then((value) async {
        //Message has been posted under message tree, now add it to the keys tree
        await ApiService.instance!.keys!
            .child(ApiService.instance!.auth!.currentUser!.uid)
            .set("");

       /*
        MessageInstance usersOwnMessage = MessageInstance(
            ApiService.instance!.auth!.currentUser!.uid,
            chosenBadgeIndex,
            0,
            title.toString(),
            message.toString(),);*/
        UserInstance? newest = Boxes.getuser().get('mainUser');

        newest!.hasPostedMessage = true;
        await Boxes.getuser().put('mainUser', newest);

        result = await incrementCounter();
      }).then((value) => null);
      return result;
    } catch (e) {
      print("there was an error in step 1 of publishing message : $e");
      return false;
    }
  }

  Future<bool> incrementCounter() async {
    try {
      final count = await ApiService.instance!.database!
          .ref('/count')
          .runTransaction((currentCount) {
        int count = currentCount == null ? 0 : currentCount as int;
        print(count);

        print("running transaction");
        return Transaction.success(count + 1);
      });
      return true;
    } catch (e) {
      print("There was an error in step 2 of publishing message (Increment)");
      return false;
    }
    //final result =
  }
}
