import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  static ApiService? _instance;
   FirebaseAuth? _auth;
  User? _user;

  ApiService._internal() {
    print("Created");
    final FirebaseAuth _auth = FirebaseAuth.instance;
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
     

      await FirebaseAuth.instance.currentUser!.delete();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  
}
