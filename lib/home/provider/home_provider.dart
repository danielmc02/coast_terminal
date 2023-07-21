import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/models/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../constants/boxes.dart';


class HomeProvider extends ChangeNotifier {
  bool metReq = false;
  double progress = 0;
  String status = "Loading";
  late BuildContext context;
  late MessageInstance? curMess;
  late int choiceLikes;
  HomeProvider(BuildContext contextz) {
    context = contextz;
    _init();
  }
  _init() async {
    print("start of home");
    HomeBuild();
  }
List<ChatInstance>? retrievedChats;
 


  Future<void> dislikeMessage() async {
    await ApiService.instance!.dislikeMessage();
  }

  Future<void> likeMessage() async {
    await ApiService.instance!.likeMessage();
  }

  Future<void> removeLike() async {
    await ApiService.instance!.removeLike();
  }

  Future<void> removeDislike() async {
    await ApiService.instance!.removeDislike();
  }

  Future<void> likesOrDislikes(String code, bool value) async {
    //find out what the default value is ie. weather or not a message was ever liked/disliked to begin with

    switch (code) {
      case "like":
        print("liked message");

        isLikeSelected = value;
        Boxes.getMessage().get('currentMessage')!.liked = isLikeSelected;
        final uptdated = Boxes.getMessage().get('currentMessage');

        await Boxes.getMessage().get('currentMessage')!.delete().then(
            (value) => Boxes.getMessage().put('currentMessage', uptdated!));

        if (isLikeSelected == true) {
          if (isDislikeSelected == true) {
            isDislikeSelected = false;
            Boxes.getMessage().get('currentMessage')!.disliked =
                isDislikeSelected;
            final uptdated = Boxes.getMessage().get('currentMessage');
            await Boxes.getMessage().get('currentMessage')!.delete().then(
                (value) => Boxes.getMessage().put('currentMessage', uptdated!));
            copiedDislikes--;
            //remove a dislike
            await removeDislike();
          }
          //add a like
          copiedLikes++;
          await likeMessage();
        } else if (isLikeSelected == false) {
          print("removing like");
          copiedLikes--;
          //remove a like

          await removeLike();
        }
        notifyListeners();
        break;

      case "dislike":
        print("disliked the message");

        isDislikeSelected = value;
        Boxes.getMessage().get('currentMessage')!.disliked = isDislikeSelected;
        final uptdated = Boxes.getMessage().get('currentMessage');

        await Boxes.getMessage().get('currentMessage')!.delete().then(
            (value) => Boxes.getMessage().put('currentMessage', uptdated!));
        if (isDislikeSelected == true) {
          if (isLikeSelected == true) {
            isLikeSelected = false;
            Boxes.getMessage().get('currentMessage')!.liked = isLikeSelected;
            final uptdated = Boxes.getMessage().get('currentMessage');
            await Boxes.getMessage().get('currentMessage')!.delete().then(
                (value) => Boxes.getMessage().put('currentMessage', uptdated!));

            copiedLikes--;
            await removeLike();
          }
          copiedDislikes++;
          await dislikeMessage();
        } else if (isDislikeSelected == false) {
          copiedDislikes--;
          //remove a dislike
          await removeDislike();
        }
        notifyListeners();

        break;
      default:
        print("Didn't recieve a proper code");
    }
  }

  Future<void> updateStats(String? stat, double? prog) async {
    stat == null ? null : status = stat;
    prog == null ? null : progress = prog;
    notifyListeners();
  }

  int likes = 0;
  int dislikes = 0;
  late int copiedLikes;
  late int copiedDislikes;
  late bool isLikeSelected;
  late bool isDislikeSelected;

  Future<void> HomeBuild() async {
   await Future.delayed(Duration(seconds: 5));
    print("in hoome");
              if(ApiService.instance!.auth!.currentUser == null)
              {
                print("Ran because refresh");
                   ApiService.instance!.signOut();
                return;
              }
              else if (  Boxes.getuser()
                      .get('mainUser') != null)
              {
     int remainingTimeInSeconds = 600 -
          (DateTime.now().millisecondsSinceEpoch -
                  Boxes.getuser()
                      .get('mainUser')!
                      .createdAt
                      .millisecondsSinceEpoch) ~/
              1000;
              print("Time left: $remainingTimeInSeconds");
              if(remainingTimeInSeconds <= 0)
              {
                print("Ran in here because ran out of time");
                ApiService.instance!.signOut();
                return;
              }
              }

    
    //if()
    curMess = await ApiService.instance!.fetchMessageIfExists();
    //notifyListeners();
    print("running home functions---");
    /*
    await updateStats("Checking that you are at an eligible campus", null);
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("Service Enabled: $serviceEnabled");
    if (serviceEnabled == false) {
      // ignore: use_build_context_synchronously
      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Your location is disabled"),
              content: Text(
                  "To ensure that you are on a compatible campus, we kindly request users to enable their location services. This allows us to verify your location and ensure that you have seamless access to all the features"),
            );
          });
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;
      print("current location is:\nLat:$latitude\nLong:$longitude");
      print(position);
      LatLngBounds orangeCoastCollegeArea = LatLngBounds(
          LatLng(33.675449, -117.918283), LatLng(33.667382, -117.907604));
      LatLngBounds homeDad = LatLngBounds(
          LatLng(33.67774, -117.951247), LatLng(33.677386, -117.951004));
      bool isAtHome = homeDad.contains(LatLng(latitude, longitude));
      bool isAtOcc =
          orangeCoastCollegeArea.contains(LatLng(latitude, longitude));
      isAtHome == true
          ? print("IT KNOWS IM AT HOMEEE")
          : print("Is not at home");

      isAtOcc == true ? print("IT KNOWS IM AT OCC") : print("Is not at OCC");
      progress = 0.5;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 4));
      //run the necessary functions before displaying home
      //The first one will be checking if a current message exists and if you need to delete it if it hit max view
      //This is good because you can update the message even if you dont want to remove it
      status = "Updating messages";
      notifyListeners();
    }*/

    if (Boxes.getMessage().get('currentMessage') != null) {
      String currentMessageKey =
          Boxes.getMessage().get('currentMessage')!.uidAdmin.toString();
      print('current message key is $currentMessageKey');
      try {
        await ApiService.instance!.keys!
            .child(currentMessageKey)
            .once()
            .then((value) async {
          //This is proof that the key still exists, therefore the respective message should as well
          //Retrieve the freshest instance of it, we can now fetch the freshest instance of the message.
          print("AAAAAAAAAAA ${value.snapshot.key}");
          String specz = value.snapshot.key as String;
          //final result = await ApiService.instance!.messagesDatabase!.child(specz).get();
          //final childNode = ApiService.instance!.messagesDatabase!.child(specz);
          final childNode = ApiService.instance!.messagesDatabase!.child(specz);
          final keyNode = ApiService.instance!.keys;

          final es = await childNode.get();

          Map spec = es.value as Map;
          print(spec);
          int curView = 0;
          int? likes;
          int? dislikes;
          bool firstTime = false;
          if (spec['Current Views'] == 0.1) {
            print("assigning curView of 0 ${spec['Current Views'].toString()}");
            curView = 1;
            //  firstTime = true;
          } else {
            print(
                "assigning curView as what it is ${spec['Current Views'].toString()}");
            curView = spec['Current Views'] as int;
          }
          if (spec["Likes"] == null) {
            print(
                "This is a fresh message with 0 likes, assigning like count to zero;");
            likes = 0;
            copiedLikes = likes;
          } else {
            print(
                "this is not a fresh message with 0 likes, assigning like count to as is value");
            likes = spec["Likes"];
            copiedLikes = likes!;
          }
          if (spec["Dislikes"] == null) {
            print(
                "This is a fresh message with 0 likes, assigning dislikes count to zero;");
            dislikes = 0;
            copiedDislikes = dislikes;
          } else {
            print(
                "this is not a fresh message with 0 dislikes, assigning dislike count to as is value");
            dislikes = spec["Dislikes"];
            copiedDislikes = dislikes!;
          }
          isDislikeSelected =
              Boxes.getMessage().get('currentMessage')!.disliked;
          isLikeSelected = Boxes.getMessage().get('currentMessage')!.liked;
//Before assigning chats we need to filter it
//spec['Chats'] == null ? print("CHAT IS NULLLL") : print("CHAT IS NOT NULL");
if(spec['Chats'] != null )
{
  print("Chats is not null");

List<ChatInstance>? chatList = await ApiService.instance!.filterChats(spec['Chats']);
retrievedChats = chatList;
print("Length of chats is ${retrievedChats!.length}");

}
          final temp = MessageInstance(
              uidAdmin: specz,
              iconIndex: spec['Badge Index'],
              views: spec['Max Views'],
              title: spec['Title'],
              message: spec['Message'],
              currentViews: curView,
              liked: Boxes.getMessage().get('currentMessage')!.liked,
              disliked: Boxes.getMessage().get('currentMessage')!.disliked,
              likes: likes,
              dislikes: dislikes);
          await Boxes.getMessage().get('currentMessage')!.delete();
          await Boxes.getMessage().put('currentMessage', temp);
          //firstTime ? await ApiService.instance!.incrementRespectedMessage(specz) : null;
          if (spec['Current Views'] == spec['Max Views'] ||
              spec['Current Views'] >= spec['Max Views']) {
            print("Just delete it, it is the last view, fell in hell");
            await childNode.remove();
          }
        });
      } catch (e) {
        print("uhohhh, The error must not exist anymore... delete it, $e");
        await Boxes.getMessage().get('currentMessage')!.delete();
      }
    } else {
      print("got in heeeerrre");
    }
    progress = 1.0;
    status = "Done";
    notifyListeners();
    // await Future.delayed(Duration(seconds: 1));
    //You need to fix the scope of the above functions, this is why nothing is working properly
    metReq = true;
    notifyListeners();
  }

   Future<void> sendChat(String message) async
  {
//    print("Here is a server value timestammp: ${ServerValue.timestamp.toString()} vs ${DateTime.now()}");
   final messageDbRef = ApiService.instance!.messagesDatabase;
   final messageNodeChats =  messageDbRef!.child(Boxes.getMessage().get('currentMessage')!.uidAdmin).child('Chats');
final reference = messageNodeChats.push();
  DateTime now = DateTime.now();
  String formattedTime = format12HourTime(now);
  String formattedDate = formatDate(now);
  String formattedDateTime = '$formattedTime $formattedDate';
  print(formattedDateTime);
String randomKey = reference.key!;
   //print(randomKey);
  await messageNodeChats.child(ServerValue.timestamp.toString()).set(
    {
      "chat": message,
      "time":formattedDateTime,
    //  "timestamp" : ServerValue.timestamp
      //DateTime: DateTime.now()

    }
   );
 //await HomeBuild();

  }



  String format12HourTime(DateTime dateTime) {
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = hour < 12 ? 'AM' : 'PM';

  hour = hour % 12;
  hour = hour == 0 ? 12 : hour;

  String hourString = hour.toString().padLeft(2, '0');
  String minuteString = minute.toString().padLeft(2, '0');

  return '$hourString:$minuteString $period';
}

String formatDate(DateTime dateTime) {
  String day = getWeekdayName(dateTime.weekday);
  String month = getMonthName(dateTime.month);
  int dayOfMonth = dateTime.day;

  return '$day $month $dayOfMonth';
}

String getWeekdayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Mon';
    case DateTime.tuesday:
      return 'Tue';
    case DateTime.wednesday:
      return 'Wed';
    case DateTime.thursday:
      return 'Thu';
    case DateTime.friday:
      return 'Fri';
    case DateTime.saturday:
      return 'Sat';
    case DateTime.sunday:
      return 'Sun';
    default:
      return '';
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}

}
