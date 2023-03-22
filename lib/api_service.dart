import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  static ApiService? _instance;
   static FirebaseAuth? _auth;
  static User? _user;

  ApiService._internal() {
    print("Created");
      _auth = FirebaseAuth.instance;
      _user = _auth!.currentUser;

   // final _user = _auth.currentUser;
  }

  static ApiService? get instance {
    _instance ??= ApiService._internal();
    return _instance;
  }

  FirebaseAuth?  get auth
  {
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

  Future deleteUser() async
  {
     
    await _user!.delete();
     // await FirebaseAuth.instance.currentUser!.delete();
  }

  Future signOut() async {
    await _auth!.signOut();
   // await FirebaseAuth.instance.signOut();
  }

  
}
