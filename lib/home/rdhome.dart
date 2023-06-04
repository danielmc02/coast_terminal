import 'dart:async';

import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../api_service.dart';
import '../constants/boxes.dart';
import '../post_page/post_page.dart';
import 'const_widgets/post_button.dart';

class RDHOME2 extends StatefulWidget {
  const RDHOME2({super.key});

  @override
  State<RDHOME2> createState() => _RDHOME2State();
}

class _RDHOME2State extends State<RDHOME2> {
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
        PageView(
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
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextTimer(Colors.grey),
                    const Text(" until automatic signout",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                backgroundColor: const Color.fromARGB(0, 13, 65, 207),
                shadowColor: const Color.fromARGB(0, 255, 0, 0),
                foregroundColor: const Color.fromARGB(0, 162, 34, 34),
                surfaceTintColor: const Color.fromARGB(0, 255, 0, 0),
              ),
              body: Consumer<HomeProvider>(
                builder: (context, algo, child) => Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      //  color: Colors.green,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              //   print("AAAAAA${snapshot.data}");
                           /*   algo.curMess*/ Boxes.getMessage().get('currentMessage') == null
                                  ? Expanded(
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
                                    )
                                  : /*algo.curMess*/ Boxes.getMessage().get('currentMessage') != null
                                      ? Expanded(
                                          flex: 40,
                                          child: Container(
                                            //  color: Colors.red,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    elevation: 20,
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                      height: 300,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  105, 0, 0, 0),
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: const Color
                                                                  .fromARGB(119,
                                                              255, 255, 255)),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        splashColor: Colors.red,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
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
                                                                      style: const TextStyle(
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
                                                                      SizedBox(
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
                                                                                const TextStyle(color: Colors.black, fontSize: 18),
                                                                            Boxes.getMessage().get('currentMessage')!.message),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                  child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  const Icon(Icons
                                                                      .remove_red_eye_outlined),
                                                                  Text(
                                                                      "${Boxes.getMessage().get('currentMessage')!.currentViews}/${Boxes.getMessage().get('currentMessage')!.views}"),
                                                                  const Spacer(),
                                                                  ChoiceChip(avatar: Icon(
                                                                              color: Colors.green,
                                                                              Icons.thumb_up),label: Text(Boxes.getMessage().get('currentMessage')!.likes.toString()), selected: false,onSelected: (value) {
                                                                                value ? algo.likesOrDislikes("like") : null;
                                                                              },),
                                                                              ChoiceChip(onSelected: (value) {
                                                                                
                                                                              },avatar: Icon(
                                                                              color: Colors.red,
                                                                              Icons.thumb_down),label: Text(Boxes.getMessage().get('currentMessage')!.dislikes.toString()), selected: false
                                                                              ),
   ],
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      : const Text("data")
                            ],
                          ),
                        ),
                      ),
                    )),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: TextFormField(
                              minLines: null,
                              validator: (value) {
                                return value!.length < 5
                                    ? "Should be greater than 5"
                                    : null;
                              },
                              controller: _chatController,
                              maxLines: 1,
                              //    maxLength: 50,
                              style: const TextStyle(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                          width: .5,
                                          color: Colors.black)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                          width: .5,
                                          color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                          width: .5,
                                          color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                          width: .5,
                                          color: Colors.black)),
                                  filled: true,
                                  suffixIcon: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        print("continue");
                                      } else {
                                        print("error, can't send chat");
                                      }
                                    },
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Send a chat",
                                  fillColor:
                                      const Color.fromARGB(255, 241, 241, 239)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                height: 100,
                elevation: 0,
                padding: const EdgeInsets.all(8),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
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
                                            MaterialStatePropertyAll(
                                                Colors.red),
                                      ),
                                      child: const Text('Delete Account'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ApiService.instance!.signOut();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.settings_outlined),
                    ),
                    PostButton(
                      onPressed: () {
                        if (Boxes.getuser().get('mainUser')!.hasPostedMessage ==
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        child: const Text("Okay, I understand"),
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
            ),
            const PostPage()
          ],
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
