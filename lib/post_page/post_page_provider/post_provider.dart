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

  Future postMessage(double sliderValue, String value, String value2) async {
    await ApiService.instance!.messagesDatabase!
        .child(ApiService.instance!.auth!.currentUser!.uid)
        .set({
      "Badge Index": chosenBadgeIndex,
      "Max Views": sliderValue,
      "Title": value.toString(),
      "Message": value2.toString()
    }).then((value) async {
      UserInstance? newest = Boxes.getuser().get('mainUser');
      newest!.hasPostedMessage = true;
      Boxes.getuser().put('mainUser', newest);
      await incrementCounter();
    });
  }

  Future incrementCounter() async {
    //final result =
    final count = await ApiService.instance!.database!
        .ref('/count')
        .runTransaction((currentCount) {
      int count = currentCount == null ? 0 : currentCount as int;
      print(count);

      print("running transaction");
      return Transaction.success(count + 1);
    });
  }

  void changeDrawer() {
    drawerIsOpen = !drawerIsOpen;
    notifyListeners();
  }
}
