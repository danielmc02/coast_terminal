import 'dart:ui';

import 'package:coast_terminal/models/contract_consent_certificate.dart';
import 'package:coast_terminal/models/root_user.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:coast_terminal/models/vip_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'api_service.dart';
import 'home/home.dart';
import 'models/message.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RootUserAdapter());
  await Hive.openBox<RootUser>('rootUser');

  Hive.registerAdapter(UserInstanceAdapter());
  await Hive.openBox<UserInstance>('user');

  Hive.registerAdapter(VipMessageAdapter());
  await Hive.openBox<VipMessage>('vipMessages');

  Hive.registerAdapter(MessageInstanceAdapter());
  await Hive.openBox<MessageInstance>('messages');

  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,

      );
  await MobileAds.instance.initialize();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coast Terminal',
      theme: ThemeData(
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontFamily: "Roboto",
                color: Colors.white,
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: TextStyle(
                  fontFamily: "Roboto", color: Colors.black, fontSize: 25),
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
  void initState() {
    // TODO: implement initState
    ApiService.instance!.createRootUserIfNeeded();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //return const ConsentPage();
    // return HomeWrapper();
    return StreamBuilder(
        stream: ApiService.instance!.getuser(),
        builder: (context, snapshot) {
          print('${snapshot.data} : Beggining');
          if (snapshot.hasData) {
            if (snapshot.data!.uid != null) {
              return const HomeWrapper();
            } else if (snapshot.data!.uid == null) {
              return const OnboardingPage();
            }
          } else if (snapshot.hasData == false) {
            return const OnboardingPage();
          }

          return const Text("errooooooooooor");
        });
  }
}
