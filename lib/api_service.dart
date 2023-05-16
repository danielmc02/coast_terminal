import 'dart:async';
import 'dart:math';

import 'package:coast_terminal/models/message.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/boxes.dart';
import 'home/provider/home_provider.dart';

class ApiService {
  static ApiService? _instance;
  static FirebaseAuth? _auth;
  static User? _user;
  static FirebaseDatabase? _database;
  static DatabaseReference? _messagesDatabase;
  static DatabaseReference? _messageCount;
  static DatabaseReference? _keys;

  ApiService._internal() {
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    _database = FirebaseDatabase.instance;
    _messagesDatabase = _database!.ref('messages');
    _messageCount = _database!.ref('count');
    _keys = _database!.ref('keys');
  }
  DatabaseReference? get messagesDatabase {
    return _messagesDatabase;
  }

  DatabaseReference? get keys {
    return _keys;
  }

  FirebaseDatabase? get database {
    return _database;
  }

  DatabaseReference? get messageCount {
    return _messageCount;
  }

  static ApiService? get instance {
    _instance ??= ApiService._internal();
    return _instance;
  }

  FirebaseAuth? get auth {
    return _auth;
  }

  bool currentMessageSucessresult = false;

  //Sign in anoynomously (guest)
  Future signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      var tempUse = userCredential.user;
      final userModel = Boxes.getuser();
      if (userModel != null) {
        print(
            " An existing UserModel instance exists. There are ${userModel.values.length}. Delete it and create new one.");

        var currentUser = UserInstance(
            tempUse!.uid, false, tempUse.metadata.creationTime!, null);
        Boxes.getuser().put('mainUser', currentUser);
        return userModel;
      } else {
        print("No existing UserModel instance exists. Create a new one.");
        var currentUser = UserInstance(
            tempUse!.uid, false, tempUse.metadata.creationTime!, null);
        Boxes.getuser().put('mainUser', currentUser);
      }

      print("Signed in with TEMPORARY account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future deleteUser() async {
    await _user!.delete();
    // await FirebaseAuth.instance.currentUser!.delete();
  }

  Future signOut() async {
    //Delete current message and user
    if(Boxes.getMessage().get('currentMessage') != null)
    {
      print("deleting currentMessage");
     await Boxes.getMessage().get('currentMessage')!.delete();
    }
    if(Boxes.getuser().get('mainUser') != null)
    {
      print("deleting user");
    await  Boxes.getuser().get('mainUser')!.delete();
    }
    await _auth!.currentUser!.delete();
    await _auth!.signOut();
    // await FirebaseAuth.instance.signOut();
  }

  Stream<User?> getuser() async* {
    yield* _auth!.userChanges();
  }

  Future<int> getMessageCount() async {
    final snapshot = await _messageCount!.get();

    // _messageCount.child(path)
    print(snapshot.value);
    int count = snapshot.value as int;
    return count;
  }

  bool ref = true;
  PageController pageController = PageController();

  List iconReferences = const [
    AssetImage('assets/face_icons/anonymous.png'),
    AssetImage('assets/face_icons/occ.jpeg'),
    AssetImage('assets/face_icons/angel.png'),
    AssetImage('assets/face_icons/angry.png'),
    AssetImage('assets/face_icons/cool.png'),
    AssetImage('assets/face_icons/cry.png'),
    AssetImage('assets/face_icons/dead.png'),
    AssetImage('assets/face_icons/demon.png'),
    AssetImage('assets/face_icons/disappointed.png'),
    AssetImage('assets/face_icons/exhale.png'),
    AssetImage('assets/face_icons/frustrated.png'),
    AssetImage('assets/face_icons/happy.png'),
    AssetImage('assets/face_icons/hide.png'),
    AssetImage('assets/face_icons/love.png'),
    AssetImage('assets/face_icons/mask.png'),
    AssetImage('assets/face_icons/neutral.png'),
    AssetImage('assets/face_icons/scared.png'),
    AssetImage('assets/face_icons/shock.png'),
    AssetImage('assets/face_icons/sus.png')
  ];
  /////////////////////

  Future incrementRespectedMessage(String Uid) async {
    //Test for 3 cases
    //1. It has never been increased so it's value is 0.1
    //2. It has been increased but isn't maxed so just increment by one
    //3. You are the last (max view), instead of incrementing, just delete it
    print('einac');
    final childNode = ApiService.instance!.messagesDatabase!.child(Uid);
    final keyNode = ApiService.instance!.keys;
    DataSnapshot snapshot =
        await ApiService.instance!.messagesDatabase!.child(Uid).get();
    print('${snapshot.value} irm');
    final snap = snapshot.value as Map;
    print('end of cast');
    if (snap['Current Views'] == 0.1) {
      print("this is the first view : ${snap['Current Views']}");
      await childNode.child('Current Views').runTransaction((value) {
        return Transaction.success(1);
      });
    } else if (snap['Current Views'] != 0.1 &&
        snap['Current Views'] + 1 < snap['Max Views']) {
      int curr = snap['Current Views'];
      curr++;
      print('This is the second test case');
      await childNode.child('Current Views').runTransaction((value) {
        return Transaction.success(curr);
      });
    } else if (snap['Current Views'] + 1 == snap['Max Views'] ||
        snap['Current Views'] >= snap['Max Views']) {
      print("Just delete it, it is the last view");
      await childNode.remove().then((value) async {
        final count = await ApiService.instance!.database!
            .ref('/count')
            .runTransaction((currentCount) {
          int count = currentCount == null ? 0 : currentCount as int;
          print(count);

          print("running transaction");
          return Transaction.success(count - 1);
        }).then((value) {
          keyNode!.child(Uid).remove();
        });
      });
    }
  }

  Future<MessageInstance?> fetchMessageIfExists() async {
    MessageInstance? currentFetchedMessage;
    Map spec = {};
    String key = "";
    try {
      DatabaseReference? messageDBref = ApiService.instance!.messagesDatabase;
      //Run a transaction to get the current count
      await ApiService.instance!.messageCount!.runTransaction((currentCount) {
        int count = currentCount == null ? 0 : currentCount as int;
        print("THE COUNT IS $count");
        return Transaction.success(count);
      }).then((value) async {
        int returnedCountValue = await value.snapshot.value as int;
        print('The final ran value is $returnedCountValue');
        if (returnedCountValue > 0) {
          String? fetchedRandomKey = await returnRandomMessageKey();

          await messageDBref!
              .child(fetchedRandomKey)
              .once()
              .then((value) async {
            spec = value.snapshot.value as Map;
            print(spec);
            print(spec['Badge Index']);
            print(spec['Max Views']);
            print(spec['Title']);
            print(spec['Message']);
            final temp = MessageInstance(fetchedRandomKey, spec['Badge Index'],
                spec['Max Views'], spec['Title'], spec['Message']);
            currentFetchedMessage = temp;
            print(currentFetchedMessage);
            await Boxes.getMessage()
                .put('currentMessage', currentFetchedMessage!);
            incrementRespectedMessage(fetchedRandomKey);


          });
        }
      });
      //print(currentFetchedMessage.title);
      return currentFetchedMessage;
    } catch (e) {
      print("FFFFFFUUUUCCCCKKKK");
      print('error in step 1: ${e}');
      return null;
    }
  }

  Future<String> returnRandomMessageKey() async {
    DatabaseReference? keysRef = ApiService.instance!.keys;
    List<String> allKeys = [];

    await keysRef!.once().then((value) async {
      final MapResults = value.snapshot.value as Map;

      MapResults.forEach(
        (key, value) {
          // print(key);
          allKeys.add(key);
        },
      );
    });
    if(allKeys.contains(auth!.currentUser!.uid.toString()))
    {
    allKeys.remove(auth!.currentUser!.uid.toString());
  print("removed own message");
    }
    int randomIndex = Random().nextInt(allKeys.length);
    print('Random IndexFetched: ${allKeys[randomIndex]}');

    return allKeys[randomIndex];
  }



}
