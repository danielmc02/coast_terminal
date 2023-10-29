import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/boxes.dart';

class PostProvider extends ChangeNotifier {
  PostProvider()
  {
    titleController = TextEditingController();
    messageController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }
    late  GlobalKey<FormState> formKey;
  double currentValue = 1;
  late TextEditingController titleController;
  late TextEditingController messageController;

  bool drawerIsOpen = false;
  Map<String, Map> badges = <String, Map>{
    'Clown': {
      'icon': Image.asset('assets/face_icons/clown.png'),
      'selected': true
    },
    'Drooling': {
      'icon': Image.asset('assets/face_icons/drooling.png'),
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
    'Demon Time': {
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
       'Vomit': {
      'icon': Image.asset('assets/face_icons/vomit.png'),
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
   
      int sliderValue, String title, String message)
      
       async {
    try {
      await ApiService.instance!.messagesDatabase!
          .child(ApiService.instance!.auth!.currentUser!.uid)
          .set({
        "Badge Index": chosenBadgeIndex,
        "Current Views": 0.1,
        "Max Views": sliderValue,
        "Title": title.toString(),
        "Message": message.toString(),
        "Blocks": 0
        

      }).then((value) async {
        await ApiService.instance!.keys!
            .child(ApiService.instance!.auth!.currentUser!.uid)
            .set("");

        UserInstance? newest = Boxes.getuser().get('mainUser');

        newest!.hasPostedMessage = true;

        await Boxes.getuser().put('mainUser', newest);

;      }).then((value) => null);
      return true;
    } catch (e) {
      return false;
    }
  }

/*
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
  }
  */
}
