import 'package:firebase_auth/firebase_auth.dart';

class ApiService
{
  static ApiService? _instance;
  late FirebaseAuth _auth;

  ApiService._internal() {
  final FirebaseAuth _auth = FirebaseAuth.instance;

    
  }

  static ApiService? get instance {
    _instance ??= ApiService._internal();
    return _instance;
  }

}