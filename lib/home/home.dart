import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
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

class _HomeWrapperState extends State<HomeWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late int randomNumber;
  @override
  void initState() {
    randomNumber = Random().nextInt(facts.length);
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween<double>(begin: null, end: null).animate(_animationController);
  }

  List<String> facts = [
    "The human brain weighs about 3 pounds (1.4 kilograms).",
    "The average person has about 70,000 thoughts per day.",
    "Honey never spoils. Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still perfectly edible.",
    "The Great Wall of China is not visible from space with the naked eye, contrary to popular belief. It's challenging to see even from low Earth orbit.",
    "The world's oldest known university is the University of Al Quaraouiyine in Morocco, founded in 859 AD.",
    "The concept of the Internet was developed in the 1960s as a means of communication that could withstand a nuclear war.",
    "Antarctica is the world's largest desert. Despite its icy reputation, it receives very little precipitation.",
    "The shortest war in history lasted just 38 to 45 minutes. It occurred between Britain and Zanzibar on August 27, 1896.",
    "The average person will spend around 6 months of their life waiting at red traffic lights.",
    "Mount Everest, the highest peak in the world, continues to grow at a rate of about 0.16 inches (4 millimeters) per year.",
    "The world's largest volcano is Mauna Loa in Hawaii. It stands about 13,678 feet (4,169 meters) above sea level.",
    "The Eiffel Tower in Paris grows taller in the summer due to the expansion of the iron from the heat.",
    "The world's largest known prime number has over 24 million digits.",
    "The average adult human body contains enough bones to make up an entire human skeleton.",
    "The average person will spend about 25 years of their life asleep.",
    "There are more possible iterations of a game of chess than there are atoms in the known universe.",
    "The shortest commercial flight in the world is between two Scottish islands, Westray and Papa Westray, and lasts only 1.7 miles (2.7 kilometers) and about 47 seconds.",
    "The world's largest underground cave chamber is the Sarawak Chamber in Malaysia, which is large enough to fit 40 Boeing 747s.",
    "The oldest known living tree, named Methuselah, is over 4,800 years old and can be found in the White Mountains of California.",
    "The human body contains enough carbon to fill about 9,000 pencils.",
    "The Hawaiian alphabet has only 12 letters: A, E, I, O, U, H, K, L, M, N, P, and W.",
    "The national animal of Scotland is the unicorn.",
    "The first recorded use of the hashtag symbol (#) to categorize topics on social media was on Twitter in 2007.",
    "The average person will eat about 35 tons of food in their lifetime.",
    "Leonardo da Vinci could write with one hand and draw with the other simultaneously.",
    "The shortest distance between Russia and the United States is about 2.4 miles (3.8 kilometers) across the Bering Strait.",
    "The world's largest pyramid is not in Egypt but in Cholula, Mexico. It is known as the Great Pyramid of Cholula.",
    "The average person produces about 25,000 quarts (23,700 liters) of saliva in a lifetime.",
    "There is a species of jellyfish known as the immortal jellyfish that can revert back to its juvenile form after reaching maturity."
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(this.context),
      builder: (context, child) => Consumer<HomeProvider>(
          builder: (context, algo, child) => algo.metReq == false
              ? Scaffold(
                  appBar: AppBar(),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: <AnimatedText>[
                              FadeAnimatedText(facts[randomNumber])
                            ]),
                        Container(
                          color: Color.fromARGB(159, 158, 158, 158),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) =>
                                      CircularProgressIndicator(
                                    strokeWidth: 15,
                                    color: Colors.black,
                                    value: algo.progress,
                                    backgroundColor: Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green),
                                  ),
                                ),
                                Center(
                                    child: Text(
                                        "${(algo.progress * 100).toStringAsFixed(algo.progress % 1 == 0 ? 0 : 1).replaceAll(RegExp(r'\.0+$'), '')}%"))
                              ],
                            ),
                          ),
                        ),
                        Text(algo.status)
                      ],
                    ),
                  ),
                )
              : Home()),
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
                  Boxes.getuser().get('mainUser')!.hasPostedMessage == true) {
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
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      Colors.grey)),
                                          child:
                                              const Text("Okay, I understand"),
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
                                    duration: Duration(milliseconds: 500),
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
                                Boxes.getMessage().get('currentMessage') != null
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
                                                  BorderRadius.circular(20),
                                              color: Color.fromARGB(
                                                  255, 138, 47, 47),
                                            ),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              splashColor: Colors.red,
                                              child: Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
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
                                                                left: 8.0),
                                                        child: FittedBox(
                                                          child: Text(
                                                            Boxes.getMessage()
                                                                .get(
                                                                    'currentMessage')!
                                                                .title,
                                                            style: TextStyle(
                                                                fontSize: 40),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Container(
                                                          //color:Colors.green,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Scrollbar(
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
                                                                      .get(
                                                                          'currentMessage')!
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
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData == true) {
                                              print(
                                                  'snapshots data is : ${snapshot.data}');
                                              if (snapshot.data != null) {
                                                return Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    elevation: 20,
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                      height: 300,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    105,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Color.fromARGB(
                                                            255, 252, 252, 252),
                                                      ),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        splashColor: Colors.red,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
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
                                                                  padding: const EdgeInsets
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
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
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontSize: 18),
                                                                            Boxes.getMessage().get('currentMessage')!.message),
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
                                            } else if (snapshot.data == null) {
                                              print(
                                                  'This ran because snapshot is : ${snapshot.data}');
                                              return Material(
                                                child: Ink(
                                                  height: 200,
                                                  color: Colors.blue,
                                                  child: AlertDialog(
                                                    title: Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text("Empty"),
                                                        Icon(
                                                          Icons
                                                              .warning_amber_outlined,
                                                          color:
                                                              Colors.redAccent,
                                                        )
                                                      ],
                                                    )),
                                                    content: Text(
                                                        "This is awkward. There are currently no messages to show at this time."),
                                                  ),
                                                ),
                                              );
                                            }
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.none) {
                                            return Text("none");
                                          } else if (snapshot.connectionState ==
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
                                  children: [Text("Previous Messages 1/2: ")],
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
