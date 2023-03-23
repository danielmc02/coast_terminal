import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/loading_screen/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
              return Scaffold(
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("intro"),
                    TextButton(
                        onPressed: () {
                          ApiService.instance!.signOut();
                        },
                        child: Text("sign out"))
                  ],
                ),
              );
            } else if (snapshot.data!.uid == null) {
              return Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(255, 20, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            '100% anonymous',
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 4,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "To support the maintenance and improvement of the app's quality, users are kindly requested to watch an ad. By doing so, users contribute to the sustainability of the app's development and its ability to provide its services."),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoadingScreen();
                                                }));
                                              },
                                              child: Text(
                                                  "Understood, take me to terminal"),
                                              style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  overlayColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Explore",
                                style: TextStyle(
                                    fontFamily: "Roboto", color: Colors.black),
                              ))),
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              onPressed: () {},
                              child: Text(
                                "How it works",
                                style: Theme.of(context).textTheme.labelLarge,
                              ))),
                    ],
                  ),
                ),
              );
            }
          }
          else if(snapshot.hasData == false)
          {
            return Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(255, 20, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            '100% anonymous',
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 4,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "To support the maintenance and improvement of the app's quality, users are kindly requested to watch an ad. By doing so, users contribute to the sustainability of the app's development and its ability to provide its services."),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoadingScreen();
                                                }));
                                              },
                                              child: Text(
                                                  "Understood, take me to terminal"),
                                              style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  overlayColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Explore",
                                style: TextStyle(
                                    fontFamily: "Roboto", color: Colors.black),
                              ))),
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              onPressed: () {},
                              child: Text(
                                "How it works",
                                style: Theme.of(context).textTheme.labelLarge,
                              ))),
                    ],
                  ),
                ),
              );
          }

          return Text("errooooooooooor");
        });
  }
}
