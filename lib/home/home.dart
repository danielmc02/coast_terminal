import 'dart:async';
import 'dart:math';

import 'package:coast_terminal/home/const_widgets/post_button.dart';
import 'package:coast_terminal/home/const_widgets/sign_out_button.dart';
import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:coast_terminal/models/message.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../constants/boxes.dart';
import '../post_page/post_page.dart';
import '../api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ConfettiController _controller;
 // late Timer _timer;

  late int remainingTime;
  void initState() {
    _controller = ConfettiController(duration: const Duration(seconds: 1));
   

    super.initState();
  }

  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ChangeNotifierProvider(
            create: (context) => HomeProvider(),
            builder: (context, child) => Consumer<HomeProvider>(
                  builder: (context, algo, child) => PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      print("page has been changed: $value");
                      if (value == 0 &&
                          Boxes.getuser().get('mainUser')!.hasPostedMessage ==
                              true) {
                        _controller.play();
                      }
                    },
                    reverse: true,
                    controller: ApiService.instance!.pageController,
                    scrollDirection: Axis.vertical,
                    children: [
                      Scaffold(
                        backgroundColor: Color.fromARGB(255, 241, 242, 246),//Dark - Color.fromARGB(255, 39, 47, 62),
                        appBar: AppBar(
                          backgroundColor: Color.fromARGB(255, 56, 62, 78),
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,actions: [TextButton(onPressed: (){ApiService.instance!.signOut();}, child: Text('saf'))],
                        ),
                        body: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            
                            FutureBuilder(future:algo.fetchMessageIfExists() ,builder: (context, snapshot) {
                              if(snapshot.hasData == true)
                              {
                                if(snapshot.data != null)
                                {
                                  return snapshot.data!;
                                }
                                else
                                {
                                  return Text("snapshot data is null");
                                }
                              }
                              else
                              {
                                return Text('THERE IS NO DATA');
                              }
                            
                            },),
                             // ApiService.instance!.heart(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  TextTimer(),
                                  Spacer(),
                                  PostButton(
                                    onPressed: () {
                                      if (Boxes.getuser()
                                              .get('mainUser')!
                                              .hasPostedMessage ==
                                          true) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                    "You can only post one message. If you would like to post a new message, please sign out and sign in again. Please note that signing out will delete all your progress, including your current message and all previously viewed messages."),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ButtonStyle(
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .black),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10))),
                                                          backgroundColor:
                                                              MaterialStateProperty.all(
                                                                  Colors.white),
                                                          overlayColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .grey)),
                                                      child: const Text(
                                                          "Okay, I understand"),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        ApiService.instance!.pageController
                                            .nextPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.linear)
                                            .then((value) {
                                          setState(() {
                                            ApiService.instance!.ref = false;
                                            Timer(Duration(seconds: 1), () {
                                              ApiService.instance!.ref = true;
                                            });
                                          });
                                        });
                                      }
                                    },
                                  ),
                                  Spacer(), //     TextButton(onPressed: (){_controller.play();}, child: Text("PLAY"))
                                  SignOutButton(),
                                  Spacer()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      PostPage(),
                    ],
                  ),
                )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirection: pi,
                maxBlastForce: 20, // set a lower max blast force
                minBlastForce: 1, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 250, // a lot of particles at once
                gravity: 1,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirection: pi,
                maxBlastForce: 20, // set a lower max blast force
                minBlastForce: 1, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 250, // a lot of particles at once
                gravity: 1,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirection: pi / 4,
                maxBlastForce: 20, // set a lower max blast force
                minBlastForce: .02, // set a lower min blast force
                emissionFrequency: 0.01,
                numberOfParticles: 250, // a lot of particles at once
                gravity: 1,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TextTimer extends StatefulWidget {
  const TextTimer({super.key});

  @override
  State<TextTimer> createState() => _TextTimerState();
}

class _TextTimerState extends State<TextTimer> {
  late Timer _timer;

  late int remainingTime;
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int remainingTimeInSeconds = 24 * 60 * 60 -
          (DateTime.now().millisecondsSinceEpoch -
                  Boxes.getuser()
                      .get('mainUser')!
                      .createdAt
                      .millisecondsSinceEpoch) ~/
              1000;

      // Update the UI with the remaining time
      if (remainingTimeInSeconds <= 0) {
        // Timer has ended, do something here

        // Cancel the timer
        timer.cancel();
        ApiService.instance!.signOut();
      } else {
        // Update the UI with the remaining time
        setState(() {
          remainingTime = remainingTimeInSeconds;
        });
      }
    });
    remainingTime = 0;
    // startTimer();

    super.initState();
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      // Calculate the remaining time in seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        style: TextStyle(color: Colors.black),
        '${remainingTime ~/ 3600}:${(remainingTime % 3600) ~/ 60}:${remainingTime % 60}');
  }
}
