import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  static ApiService? _instance;
  static FirebaseAuth? _auth;
  static User? _user;
  static FirebaseDatabase? _database;
  static DatabaseReference? _messagesDatabase;
  static DatabaseReference? _messageCount;

  ApiService._internal() {
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    _database = FirebaseDatabase.instance;
    _messagesDatabase = _database!.ref('messages'); 
    _messageCount = _database!.ref('count');

  }
  DatabaseReference? get messagesDatabase
  {
    return _messagesDatabase;
  }
    DatabaseReference? get messageCount
  {
    return _messageCount;
  }
  

  static ApiService? get instance {
    _instance ??= ApiService._internal();
    return _instance;
  }

  FirebaseAuth? get auth {
    return _auth;
  }

  //Sign in anoynomously (guest)
  Future signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print(userCredential.user);
      //_user = _auth.currentUser;
      print("Signed in with temporary account.");
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
    await _auth!.signOut();
    // await FirebaseAuth.instance.signOut();
  }

  Future fetchMessage() async {}
  
    Stream<User?> getuser() async* {
    yield* _auth!.userChanges();
  }

  Future getMessageCount() async
  {
    final snapshot = await _messageCount!.get();

   // _messageCount.child(path)
    return snapshot.value;
  }
  bool ref = true;
  PageController pageController = PageController();
  
}
