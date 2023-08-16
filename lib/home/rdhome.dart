import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../api_service.dart';
import '../constants/boxes.dart';
import '../post_page/post_page.dart';

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
  List<Map<dynamic, dynamic>> chats = [];

  @override
  void initState() {
    _controller = ConfettiController(duration: const Duration(seconds: 1));

    //if a current message exists, check it's count
    _chatController = TextEditingController();
    print('home has now been initialized');
    fetchAndDisplyChats();
    super.initState();
  }

  void fetchAndDisplyChats() {
    if (Boxes.getMessage().get('currentMessage') != null) {
      final chatRef = ApiService.instance!.messagesDatabase!
          .child(Boxes.getMessage().get('currentMessage')!.uidAdmin)
          .child('Chats');
      final query = chatRef.orderByChild('timestamp');
      query.onValue.listen((event) {
// print(event.snapshot.toString());
        //Map messages = event.snapshot.value as Map;

        //print(messages);
      });
      print("CHHHHHHHHHHHHHHHHHHHEEEEEEEESSEESSEE");
    }
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
              FocusManager.instance.primaryFocus?.unfocus();

              _controller.play();
            }
          },
          reverse: true,
          controller: ApiService.instance!.pageController,
          scrollDirection: Axis.vertical,
          children: [
            Scaffold(
                backgroundColor: Colors.white,
                /*   drawer: Drawer(
                  // Add a ListView to the drawer. This ensures the user can scroll
                  // through the options in the drawer if there isn't enough vertical
                  // space to fit everything.
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Text('Drawer Header'),
                      ),
                      ListTile(
                        title: const Text('Item 1'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      ListTile(
                        title: const Text('Item 2'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                    ],
                  ),
                ),
          */
                appBar: AppBar(
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  //  toolbarHeight: 0.5,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextTimer(Colors.grey),
                      const Text(" until automatic signout",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  surfaceTintColor: const Color.fromARGB(0, 255, 0, 0),
                ),
                body: Consumer<HomeProvider>(
                  builder: (context, algo, child) => Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                // height: 40,
                                // color: Colors.green,
                                child:
                                    Boxes.getMessage().get('currentMessage') !=
                                            null
                                        ? SingleChildScrollView(
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(left:8,right: 8,bottom: 40),
                                                            child: Material(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              elevation: 6,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  0, 199, 64, 64),
                                                              child: Ink(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border:
                                                                      Border.all(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        105,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(16),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          radius:
                                                                              30,
                                                                          foregroundImage: ApiService
                                                                              .instance!
                                                                              .iconReferences[Boxes
                                                                                  .getMessage()
                                                                              .get('currentMessage')!
                                                                              .iconIndex],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8),
                                                                        FittedBox(
                                                                          child:
                                                                              Text(
                                                                            Boxes.getMessage()
                                                                                .get('currentMessage')!
                                                                                .title,
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 40),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8),
                                                                        AnimatedTextKit(
                                                                          totalRepeatCount:
                                                                              1,
                                                                          animatedTexts: <TyperAnimatedText>[
                                                                            TyperAnimatedText(
                                                                              Boxes.getMessage().get('currentMessage')!.message,
                                                                              textStyle:
                                                                                  const TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "OpenSans",
                                                                                color: Colors.white,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8),
                                                                     algo.hasBeenDeleted == false && algo.hasBeenReported == false ?   Row(
                                                                          children: [
                                                                            const Icon(
                                                                              color:
                                                                                  Colors.white,
                                                                              Icons.remove_red_eye_outlined,
                                                                            ),
                                                                            Text(
                                                                                style: const TextStyle(color: Colors.white),
                                                                                "${Boxes.getMessage().get('currentMessage')!.currentViews}/${Boxes.getMessage().get('currentMessage')!.views}"),
                                                                            const Spacer(),
                                                                            algo.canInteractWithMessage
                                                                                ? Row(
                                                                                    children: [
                                                                                      ChoiceChip(
                                                                                        // backgroundColor: Colors.black,
                                                                                        //    backgroundColor: algo.isLikeSelected ? Colors.black : Colors.white,
                                                                                        elevation: algo.isLikeSelected ? 8 : 0,
                                                                                        avatar: const Icon(color: Colors.green, Icons.thumb_up),
                                                                                        label: Text(algo.copiedLikes.toString() /*Boxes
                                                                                                 .getMessage()
                                                                                             .get(
                                                                                                 'currentMessage')!
                                                                                             .likes
                                                                                             .toString()*/
                                                                                            ),
                                                                                        selected: algo.isLikeSelected,
                                                                                        onSelected: (value) async {
                                                                                          await algo.likesOrDislikes("like", value);
                                                                                        },
                                                                                        selectedColor: algo.isLikeSelected ? Colors.white : Colors.transparent,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 8,
                                                                                      ),
                                                                                      ChoiceChip(
                                                                                        //disabledColor: Colors.red,
                                                                                        // backgroundColor: Colors.red,
                                                                                        elevation: algo.isDislikeSelected ? 8 : 0,
                                        
                                                                                        selectedColor: Colors.white,
                                                                                        onSelected: (value) async {
                                                                                          await algo.likesOrDislikes("dislike", value);
                                                                                        },
                                                                                        avatar: const Icon(color: Colors.red, Icons.thumb_down),
                                                                                        label: Text(algo.copiedDislikes.toString() /*Boxes
                                                                                                 .getMessage()
                                                                                             .get(
                                                                                                 'currentMessage')!
                                                                                             .dislikes
                                                                                             .toString()*/
                                                                                            ),
                                                                                        selected: algo.isDislikeSelected,
                                                                                      ),
                                                                                    const SizedBox(
                                                                                        width: 8,
                                                                                      ), GestureDetector(onTap: () {
                                                                                             showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    SizedBox(
                                        //   color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.red),
                                                foregroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.white),
                                                shape: MaterialStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20)))),
                                            onPressed: () async {
                                             await algo.blockPost();
                                             Navigator.pop(context);
                                            },
                                            child:  Text( Boxes.getMessage().get('currentMessage')!.blocks >= Boxes.getMessage().get('currentMessage')!.views*0.20 ? "Delete Post" : "Report")))
                                  ],
                                  content:  Text(
Boxes.getMessage().get('currentMessage')!.blocks >= Boxes.getMessage().get('currentMessage')!.views*0.20  == false ? "By choosing to report this message, you will no longer receive posts from this user upon your next sign-in. Your decision to report this message provides other users with the opportunity to potentially have this post removed from the server, given sufficient community support." : "It appears that this message has been deemed inconsistent with our community guidelines by other users. You have the option to remove this message if you wish.",
textAlign: TextAlign.center,
                                  ),
                                  title: const Text(
                                    "Sorry about that",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              );
                         

                                                                                      },child: Icon(Icons.report,color: Colors.red,))
                                                                                    ],
                                                                                  )
                                                                                : Flexible(
                                                                                    child: Container(
                                                                                        color: Colors.transparent,
                                                                                        //width: MediaQuery.of(context).size.width,
                                                                                        child: SizedBox(
                                                                                          width: 200,
                                                                                          height: 100,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: AnimatedTextKit(repeatForever: true, animatedTexts: <FadeAnimatedText>[
                                                                                              FadeAnimatedText(
                                                                                                duration: const Duration(seconds: 6),
                                                                                                "You have been given coins because you are the last view",
                                                                                                textStyle: const TextStyle(
                                                                                                  color: Color.fromARGB(101, 255, 255, 255),
                                                                                                  //   fontSize: 32
                                                                                                ),
                                                                                              )
                                                                                            ]),
                                                                                          ),
                                                                                        )))
                                                                          ],
                                                                        )
                                                               : Text("The Message has been ${algo.hasBeenReported ? "reported" : "deleted"}")  ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        )
                                        : Column(
                                            children: [
                                              Container(
                                                //    color: Colors.white,
                                                child:  AlertDialog(
                                                  title: const Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Empty"),
                                                      Icon(
                                                        Icons
                                                            .warning_amber_outlined,
                                                        color: Colors.redAccent,
                                                      )
                                                    ],
                                                  )),
                                                  content: RichText(
            text: TextSpan(
              text: 'This is awkward. There are currently no messages to show at this time. You can change that by posting a message. Or you can ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = ()async{
                   await ApiService.instance!.signOut();
                  }
                  ,
                  text: 'sign out',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
                                                ),
                                              ),
                                              //   RiveAnimation.asset('assets/rive_assets/plane.riv'),
                                              Image.asset("assets/lol.png"),
                                            ],
                                          ))),
                        /*         Container(
                            color: Colors.transparent,
                            child: Boxes.getMessage().get('currentMessage') !=
                                    null
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            minLines: null,
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
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      style: BorderStyle.solid,
                                                      width: .5,
                                                      color: Colors.black)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      style: BorderStyle.solid,
                                                      width: .5,
                                                      color: Colors.black)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      style: BorderStyle.solid,
                                                      width: .5,
                                                      color: Colors.black)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      style: BorderStyle.solid,
                                                      width: .5,
                                                      color: Colors.black)),
                                              filled: true,
                                              suffixIcon: TextButton(
                                                style: const ButtonStyle(),
                                                onPressed: () {
                                                  print("continue");
                                                  String message =
                                                      _chatController.text;
                                                  print(message);
                                                  _chatController.clear();
                                                  algo.sendChat(message);
                                                },
                                                child: const Icon(
                                                  Icons.send,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              hintText: "Send a chat",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : null),
                              */
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            if (Boxes.getuser()
                                    .get('mainUser')!
                                    .hasPostedMessage ==
                                true) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    SizedBox(
                                        //   color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.black),
                                                foregroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.white),
                                                shape: MaterialStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20)))),
                                            onPressed: () async {
                                              Navigator.pop(context);

                                              await ApiService.instance!
                                                  .signOut();
                                            },
                                            child: const Text("Okay")))
                                  ],
                                  content: const Text(
                                    "You can only post one message. If you would like to post a new message, please sign out and sign in again. Please note that signing out will delete all your progress, including your current message and all previously viewed messages.",
                                    textAlign: TextAlign.center,
                                  ),
                                  title: const Text(
                                    "Slow down",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              );
                            } else {
                              ApiService.instance!.pageController
                                  .nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
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
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 0, 0, 0)),
                              overlayColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 255, 34, 111))),
                          child: Text(
                            "Post",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      )
                    ],
                  ),
                )
                /*
                BottomNavigationBar(
                  backgroundColor: Colors.white,
                 // fixedColor: Colors.red,
               
                  elevation: 9,
                 selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  onTap: (value) {
                    print(value);
                    switch (value) {
                      case 0:
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              SizedBox(
                                  //   color: Colors.red,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.purple),
                                          foregroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white),
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)))),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Scan Code"))),
                              SizedBox(
                                  //   color: Colors.red,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.green),
                                          foregroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white),
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)))),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const PrivatePostPage();
                                          },
                                        ));
                                      },
                                      child:
                                          const Text("Post Private Message")))
                            ],
                            //alignment: Alignment.center,
                
                            content: const Text(
                              "VIP posts can only be seen by one person and must be scanned physically via qr code.",
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: const Text(
                              "VIP Posts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                        break;
                      case 1:
                        if (Boxes.getuser().get('mainUser')!.hasPostedMessage ==
                            true) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                SizedBox(
                                    //   color: Colors.red,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.black),
                                            foregroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.white),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)))),
                                        onPressed: () async {
                                          Navigator.pop(context);
                
                                          await ApiService.instance!.signOut();
                                        },
                                        child: const Text("Okay")))
                              ],
                              content: const Text(
                                "You can only post one message. If you would like to post a new message, please sign out and sign in again. Please note that signing out will delete all your progress, including your current message and all previously viewed messages.",
                                textAlign: TextAlign.center,
                              ),
                              title: const Text(
                                "Slow down",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
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
                        break;
                      case 2:
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 2,
                              color: Colors.white54,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                    children: [
                      Icon(Icons.generating_tokens,color: const Color.fromARGB(255, 177, 159, 0),),
                      Text("Coins: ${Boxes.getRootUser().get('CurrentRootUser')!.coins}",style: TextStyle(fontFamily: "OpenSans",color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  ),
                                  //const Text('Modal BottomSheet'),
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red),
                                    ),
                                    child: const Text('Delete Account'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            SizedBox(
                                                //   color: Colors.red,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            const MaterialStatePropertyAll(
                                                                Colors.red),
                                                        foregroundColor:
                                                            const MaterialStatePropertyAll(
                                                                Colors.white),
                                                        shape: MaterialStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)))),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                
                                                      await ApiService.instance!
                                                          .signOut();
                                                    },
                                                    child:
                                                        const Text("Sign Out")))
                                          ],
                                          //alignment: Alignment.center,
                
                                          content: const Text(
                                            "Careful! You are about to sign out. This means you will lose access to your current message. You will still be able to see your published message only when it has reached it's max views.",
                                            textAlign: TextAlign.center,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: const Text(
                                            "You are about to leave",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                      // Navigator.pop(context);
                                      //    ApiService.instance!.signOut();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        break;
                
                      default:
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(
                        label: "VIP", icon: Icon(Icons.qr_code)),
                    BottomNavigationBarItem(
                        label: "Post", icon: Icon(Icons.add)),
                    BottomNavigationBarItem(
                        label: "Profile", icon: Icon(Icons.person))
                  ],
                )
*/
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
    //await ApiService.instance!.checkLife();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int remainingTimeInSeconds = 300
          //  600 (10 mins)
          -
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
    return Consumer<HomeProvider>(
      builder: (context, algo, child) {
        if (remainingTime % 30 == 0) {
          //print("HSADPFHS");
          //  algo.HomeBuild();
        }

        return SizedBox(
          //width: 65,
          //Hours handle = ${remainingTime ~/ 3600}:
          child: Text(
            '${(remainingTime % 3600 ~/ 60).toString()}:${(remainingTime % 60).toString().padLeft(2, '0')}',
            style: TextStyle(color: widget.color, overflow: TextOverflow.fade),
          ),
        );
      },
    );
  }
}
