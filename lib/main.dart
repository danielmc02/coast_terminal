import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/home/home.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:coast_terminal/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserInstanceAdapter());
  await Hive.openBox<UserInstance>('mainUser');
  await Firebase.initializeApp();

    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coast Terminal',
      theme: ThemeData(
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontFamily: "Roboto",
                color: Colors.white,
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
              ),bodyLarge: TextStyle(fontFamily: "Roboto", color: Colors.black,fontSize: 25),
              labelLarge:
                  TextStyle(fontFamily: "Roboto", color: Colors.white))),
      home: const OnboardScreen(),
    );
  }
}

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ApiService.instance!.getuser(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            if (snapshot.data!.uid != null) {
              return Home();
            } else if (snapshot.data!.uid == null) {
              return OnboardingPage();
            }
          } else if (snapshot.hasData == false) {
            return OnboardingPage();
          }

          return const Text("errooooooooooor");
        });
  }
}
