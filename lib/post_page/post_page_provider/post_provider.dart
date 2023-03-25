import 'package:flutter/cupertino.dart';

class PostProvider extends ChangeNotifier {
  Map<String, Map> badges = {
    'Angel': {'icon': Image.asset('assets/face_icons/angel.png')},
    'Angry': {'icon': Image.asset('assets/face_icons/angry.png')},
    'Anonymous': {'icon': Image.asset('assets/face_icons/anonymous.png')},
    'Cool': {'icon': Image.asset('assets/face_icons/cool.png')},
    'Cry': {'icon': Image.asset('assets/face_icons/cry.png')},
    'Dead': {'icon': Image.asset('assets/face_icons/dead.png')},
    'Demon': {'icon': Image.asset('assets/face_icons/demon.png')},
    'Disappointed': {'icon': Image.asset('assets/face_icons/disappointed.png')},
    'Exhale': {'icon': Image.asset('assets/face_icons/exhale.png')},
    'Frustrated': {'icon': Image.asset('assets/face_icons/frustrated.png')},
    'Happy': {'icon': Image.asset('assets/face_icons/happy.png')},
    'Hide': {'icon': Image.asset('assets/face_icons/hide.png')},
    'Love': {'icon': Image.asset('assets/face_icons/love.png')},
    'Mask': {'icon': Image.asset('assets/face_icons/mask.png')},
    'Neutral': {'icon': Image.asset('assets/face_icons/neutral.png')},
    'Occ': {'icon': Image.asset('assets/face_icons/occ.jpeg')},
    'Scared': {'icon': Image.asset('assets/face_icons/scared.png')},
    'Shock': {'icon': Image.asset('assets/face_icons/shock.png')},
    'Sus': {'icon': Image.asset('assets/face_icons/sus.png')},
    'Unmasked': {'icon': Image.asset('assets/face_icons/unmasked.png')},
  };
}
