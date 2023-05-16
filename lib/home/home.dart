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
import 'package:provider/provider.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(this.context),
      builder: (context, child) => Consumer<HomeProvider>(
        builder: (context, algo, child) => algo.metReq == false ? Scaffold(
                appBar: AppBar(),
                body: Container(width: MediaQuery.of(context).size.width,
                child: Column(
                  
                  children: [
                    
                    CircularProgressIndicator(
                      strokeWidth: 7,
                      color: Colors.black,
                      value: algo.progress,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    Text(algo.status)
                  ],
                ),),
              ) :  Home()
        
      ),
    );
  }
}

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
    //if a current message exists, check it's count

    print('home has now been initialized');
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<HomeProvider>(
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
                    bottomNavigationBar: BottomAppBar(
                      height: 100,
                      elevation: 0,
                      padding: EdgeInsets.all(8),
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextTimer(),
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
                                          mainAxisSize: MainAxisSize.max,
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
                                                              BorderRadius
                                                                  .circular(
                                                                      10))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  overlayColor:
                                                      MaterialStateProperty
                                                          .all(Colors.grey)),
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
                          SignOutButton(),
                        ],
                      ),
                    ),
                    backgroundColor: Color.fromARGB(255, 241, 242,
                        246), //Dark - Color.fromARGB(255, 39, 47, 62),
                    appBar: AppBar(
                      backgroundColor: Color.fromARGB(255, 56, 62, 78),
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      actions: [
                        TextButton(
                            onPressed: () {
                              ApiService.instance!.signOut();
                            },
                            child: Text('saf'))
                      ],
                    ),
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 100,
                              child: Container(
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    Boxes.getMessage()
                                                .get('currentMessage') !=
                                            null
                                        ? Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              elevation: 20,
                                              color: Colors.transparent,
                                              child: Ink(
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          105, 0, 0, 0),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                  color: Color.fromARGB(
                                                      255, 138, 47, 47),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                  splashColor: Colors.red,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            radius: 30,
                                                            foregroundImage: ApiService
                                                                .instance!
                                                                .iconReferences[Boxes
                                                                    .getMessage()
                                                                .get(
                                                                    'currentMessage')!
                                                                .iconIndex]),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left:
                                                                        8.0),
                                                            child:
                                                                FittedBox(
                                                              child: Text(
                                                                Boxes.getMessage()
                                                                    .get(
                                                                        'currentMessage')!
                                                                    .title,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        40),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top:
                                                                        8.0),
                                                            child:
                                                                Container(
                                                              //color:Colors.green,
                                                              width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width,
                                                              child:
                                                                  Scrollbar(
                                                                thumbVisibility:
                                                                    false,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Text(
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18),
                                                                      Boxes.getMessage()
                                                                          .get('currentMessage')!
                                                                          .message),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : FutureBuilder(
                                            future: ApiService.instance!
                                                .fetchMessageIfExists(),
                                            builder: (context, snapshot) {
                                              if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasData ==
                                                    true) {
                                                  print(
                                                      'snapshots data is : ${snapshot.data}');
                                                  if (snapshot.data !=
                                                      null) {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20),
                                                        elevation: 20,
                                                        color: Colors
                                                            .transparent,
                                                        child: Ink(
                                                          height: 300,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Color
                                                                    .fromARGB(
                                                                        105,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: Color
                                                                .fromARGB(
                                                                    255,
                                                                    252,
                                                                    252,
                                                                    252),
                                                          ),
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            splashColor:
                                                                Colors.red,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          16),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  CircleAvatar(
                                                                      backgroundColor: Colors
                                                                          .transparent,
                                                                      radius:
                                                                          30,
                                                                      foregroundImage: ApiService
                                                                          .instance!
                                                                          .iconReferences[Boxes
                                                                              .getMessage()
                                                                          .get('currentMessage')!
                                                                          .iconIndex]),
                                                                  Flexible(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.only(left: 8.0),
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            Text(
                                                                          Boxes.getMessage().get('currentMessage')!.title,
                                                                          style: TextStyle(fontSize: 40),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.only(top: 8.0),
                                                                      child:
                                                                          Container(
                                                                        //color:Colors.green,
                                                                        width:
                                                                            MediaQuery.of(context).size.width,
                                                                        child:
                                                                            Scrollbar(
                                                                          thumbVisibility: false,
                                                                          child: SingleChildScrollView(
                                                                            child: Text(style: TextStyle(color: Colors.black, fontSize: 18), Boxes.getMessage().get('currentMessage')!.message),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                } else if (snapshot.data ==
                                                    null) {
                                                  print(
                                                      'This ran because snapshot is : ${snapshot.data}');
                                                  return Material(child: Ink(height: 200,color: Colors.blue,child: AlertDialog(title: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Empty"),
                                                      Icon(Icons.warning_amber_outlined,color: Colors.redAccent,)
                                                    ],
                                                  )),content: Text("This is awkward. There are currently no messages to show at this time."),),),);
                                                }
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.none) {
                                                return Text("none");
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.active) {
                                                return Text('waiting');
                                              } else {
                                                return Text('error');
                                              }
                                              throw e;
                                            },
                                          ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 50,
                              child: Container(
                                //color: Colors.green,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Previous Messages 1/2: ")
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  PostPage(),
                ],
              ),
            ),
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
    return SizedBox(
      width: 65,
      child: Text(
        '${remainingTime ~/ 3600}:${(remainingTime % 3600 ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
