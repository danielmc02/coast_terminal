import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/home/home.dart';
import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:coast_terminal/loading_screen/loading_screen.dart';
import 'package:coast_terminal/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
              ),
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
