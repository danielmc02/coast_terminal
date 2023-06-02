import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/home/const_widgets/post_button.dart';
import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:coast_terminal/home/rdhome.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../constants/boxes.dart';
import '../post_page/post_page.dart';
import '../api_service.dart';

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
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
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
                  appBar: AppBar(
                    backgroundColor: const Color.fromARGB(0, 210, 222, 255),
                    shadowColor: Colors.transparent,
                    foregroundColor: const Color.fromARGB(0, 162, 34, 34),
                    surfaceTintColor: Colors.transparent,
                  ),
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              totalRepeatCount: 3,
                              // pause: Duration(seconds: 0),
                              animatedTexts: <AnimatedText>[
                                FadeAnimatedText(facts[randomNumber],
                                    duration: const Duration(seconds: 300),
                                    fadeInEnd: .005,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.center)
                              ]),
                        ),
                        Container(
                          //color: Color.fromARGB(159, 158, 158, 158),
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
                                    valueColor: const AlwaysStoppedAnimation<Color>(
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
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          algo.status,
                          style: const TextStyle(
                              color: Color.fromARGB(110, 0, 0, 0)),
                        )
                      ],
                    ),
                  ),
                )
              : const RDHOME2() //Home()
          ),
    );
  }
}

/*
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ConfettiController _controller;
  // late Timer _timer;
  late TextEditingController _chatController;
  late int remainingTime;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = ConfettiController(duration: const Duration(seconds: 1));
    //if a current message exists, check it's count
    _chatController = TextEditingController();
    print('home has now been initialized');
    super.initState();
  }

  @override
  void dispose() {
    _chatController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<HomeProvider>(
          builder: (context, algo, child) => PageView(
            physics: const NeverScrollableScrollPhysics(),
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
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            height: MediaQuery.of(context).size.height / 2,
                            color: Colors.white54,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet'),
                                ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red)),
                                  child: const Text('Delete Account'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ApiService.instance!.signOut();
                                  },
                                ),
                              ],
                            )));
                      },
                    );
                  },
                  child: const Icon(Icons.settings_outlined),
                ),
                bottomNavigationBar: BottomAppBar(
                  height: 100,
                  elevation: 0,
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear)
                                .then((value) {
                              setState(() {
                                ApiService.instance!.ref = false;
                                Timer(const Duration(seconds: 1), () {
                                  ApiService.instance!.ref = true;
                                });
                              });
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 241, 242,
                    246), //Dark - Color.fromARGB(255, 39, 47, 62),
                appBar: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextTimer(Colors.red),
                      const Text(" until automatic signout",
                          style:
                              TextStyle(color: Color.fromARGB(150, 0, 0, 0))),
                    ],
                  ),
                  backgroundColor: const Color.fromARGB(0, 210, 222, 255),
                  shadowColor: Colors.transparent,
                  foregroundColor: const Color.fromARGB(0, 162, 34, 34),
                  surfaceTintColor: Colors.transparent,
                ),
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FutureBuilder(
                        future: ApiService.instance!.fetchMessageIfExists(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text("Loading"),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            print("AAAAAA${snapshot.data}");
                            if (snapshot.data == null) {
                              return Expanded(
                                flex: 80,
                                child: Container(
                                  //   color: Colors.red,
                                  child: const AlertDialog(
                                    title: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Empty"),
                                        Icon(
                                          Icons.warning_amber_outlined,
                                          color: Colors.redAccent,
                                        )
                                      ],
                                    )),
                                    content: Text(
                                        "This is awkward. There are currently no messages to show at this time."),
                                  ),
                                ),
                              );
                            } else if (snapshot.data != null) {
                              return Expanded(
                                  flex: 80,
                                  child: Container(
                                    color: Colors.red,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 20,
                                            color: Colors.transparent,
                                            child: Ink(
                                              height: 300,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color.fromARGB(
                                                          105, 0, 0, 0),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: const Color.fromARGB(
                                                      119, 255, 255, 255)),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                splashColor: Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
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
                                                              style: const TextStyle(
                                                                  fontSize: 40),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: SizedBox(
                                                            //color:Colors.green,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Scrollbar(
                                                              thumbVisibility:
                                                                  false,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Text(
                                                                    style: const TextStyle(
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
                                                      ),
                                                      Flexible(
                                                          child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          const Icon(Icons
                                                              .remove_red_eye_outlined),
                                                          Text(
                                                              "${Boxes.getMessage().get('currentMessage')!.currentViews}/${Boxes.getMessage().get('currentMessage')!.views}"),
                                                          const Spacer(),
                                                          TextButton(
                                                              onPressed: () {},
                                                              child: const Row(
                                                                children: [
                                                                  Icon(
                                                                      color: Colors
                                                                          .green,
                                                                      Icons
                                                                          .thumb_up),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text('3')
                                                                ],
                                                              )),
                                                          TextButton(
                                                              onPressed: () {},
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                      color: Colors
                                                                          .red,
                                                                      Icons
                                                                          .thumb_down),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text('3')
                                                                ],
                                                              ))
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            key: _formKey,
                                            child: TextFormField(
                                              validator: (value) {
                                                return value!.length < 5
                                                    ? "Should be greater than 5"
                                                    : null;
                                              },
                                              controller: _chatController,
                                              maxLines: 1,
                                              maxLength: 50,
                                              style: const TextStyle(),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: const BorderSide(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: .5,
                                                          color: Colors.black)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: const BorderSide(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: .5,
                                                          color: Colors.black)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: const BorderSide(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: .5,
                                                          color: Colors.black)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                      borderSide: const BorderSide(style: BorderStyle.solid, width: .5, color: Colors.black)),
                                                  filled: true,
                                                  suffixIcon: TextButton(
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        print("continue");
                                                      } else {
                                                        print(
                                                            "error, can't send chat");
                                                      }
                                                    },
                                                    child: const Icon(
                                                      Icons.send,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  hintText: "Send a chat",
                                                  fillColor: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                          }
                          return const Text("error");
                        },
                      )
                    ],
                  ),
                ),
              ),
              const PostPage(),
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
  TextTimer(this.color, {super.key});
  late MaterialColor color;
  @override
  State<TextTimer> createState() => _TextTimerState();
}

class _TextTimerState extends State<TextTimer> {
  late Timer _timer;

  late int remainingTime;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // Calculate the remaining time in seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 65,
      child: Text(
        '${remainingTime ~/ 3600}:${(remainingTime % 3600 ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
        style: TextStyle(color: widget.color, overflow: TextOverflow.fade),
      ),
    );
  }
}
*/