import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../api_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  RewardedAd? _rewardedAd;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';
  Future<LoadAdError?> loadAd() async {
    await RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) async {
              print('ad dismissed full screen content.');
              ad.dispose();
              Navigator.pop(context);
              await ApiService.instance!.signInAnon();
            },
          );
          print('$ad loaded');
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          print(error);
        }));
  }

  late PageController? _pageController;
  List<String> headings = [
    'Student Interactions',
    'Incognito Posts',
    'Blazingly Fast'
  ];
  List<String> subHeading = [
    "We get it, it gets boring sometimes. That's why we made this app to post incognito posts for and by fellow students",
    "Let people know how you feel. Create a message for a certain amount of people to interact with and see.",
    "Some say it's faster than sonic"
  ];
  late List<TyperAnimatedText> choices;

  int titleIndex = 0;
  void initState() {
    loadAd();
    _pageController = PageController();
    choices = [
      TyperAnimatedText(
          "We get it, it gets boring sometimes. That's why we made this app to post incognito posts for and by fellow students",
          textAlign: TextAlign.center),
      TyperAnimatedText(
          "Let people know how you feel. Create a message for a certain amount of people to interact with and see.",
          textAlign: TextAlign.center),
      TyperAnimatedText("Some say it's faster than sonic",
          textAlign: TextAlign.center),
    ];
    super.initState();
  }

  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: Container(
                                decoration: const BoxDecoration(
                                    // color: Color.fromARGB(255, 45, 216, 60),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50))),
                                child: PageView(
                                  reverse: false,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: _pageController,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 400,
                                        height: 400,
                                        child: Image.asset(
                                            "assets/animated_icons/loop_communicate.gif"),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 400,
                                        height: 400,
                                        child: Image.asset(
                                            "assets/animated_icons/eye.gif"),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 400,
                                        height: 400,
                                        child: Image.asset(
                                            "assets/animated_icons/message.gif"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: AnimatedTextKit(
                                      onNextBeforePause: (p0, p1) {
                                        //  print(p0);
                                        setState(() {
                                          titleIndex++;

                                          if (titleIndex >= headings.length) {
                                            titleIndex = 0;
                                            _pageController!.jumpToPage(0);
                                          }
                                        });
                                      },
                                      onNext: (p0, p1) {
                                        setState(() {
                                          _pageController!.animateToPage(
                                              titleIndex,
                                              duration: Duration(seconds: 1),
                                              curve: Curves.decelerate);
                                        });
                                      },
                                      pause: Duration(milliseconds: 500),
                                      repeatForever: true,
                                      isRepeatingAnimation: true,
                                      animatedTexts: <AnimatedText>[
                                        FadeAnimatedText(
                                            duration: Duration(seconds: 5),
                                            textAlign: TextAlign.center,
                                            headings[titleIndex],
                                            textStyle: GoogleFonts.poppins(
                                                fontSize: 35)),
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Text(
                                    subHeading[titleIndex],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(),
                                  )),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 150,
                              height: 50,
                              child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.grey)),
                                  onPressed: () {
                                    Platform.isAndroid
                                        ? showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                      "To support the maintenance and improvement of the app's quality, users are kindly requested to watch an ad. By doing so, users contribute to the sustainability of the app's development and its ability to provide its services."),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () async {
                                                                    await _rewardedAd!
                                                              .show(
                                                            onUserEarnedReward:
                                                                (ad, reward) {
                                                              print(
                                                                  "here is your award");
                                                            },
                                                          );
                                                        },
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                            backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    Colors
                                                                        .white),
                                                            overlayColor:
                                                                MaterialStateProperty.all(
                                                                    Colors.grey)),
                                                        child: const Text(
                                                            "Understood, take me to terminal"),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Platform.isIOS == true
                                            ? showCupertinoModalPopup(
                                                context: context,
                                                builder: (context) {
                                                  return CupertinoAlertDialog(
                                                    title: Text("Hold on!"),
                                                    content: const Text(
                                                        "To support the maintenance and improvement of the app's quality, users are kindly requested to watch an ad. By doing so, users contribute to the sustainability of the app's development and its ability to provide its services."),
                                                    actions: <
                                                        CupertinoDialogAction>[
                                                      CupertinoDialogAction(
                                                        /// This parameter indicates this action is the default,
                                                        /// and turns the action's text to bold text.
                                                        isDefaultAction: true,
                                                        isDestructiveAction:
                                                            true,

                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'No',
                                                        ),
                                                      ),
                                                      CupertinoDialogAction(
                                                        /// This parameter indicates the action would perform
                                                        /// a destructive action such as deletion, and turns
                                                        /// the action's text color to red.
                                                        isDestructiveAction:
                                                            false,
                                                        isDefaultAction: true,
                                                        onPressed: () async {
                                                          await _rewardedAd!
                                                              .show(
                                                            onUserEarnedReward:
                                                                (ad, reward) {
                                                              print(
                                                                  "here is your award");
                                                            },
                                                          );
                                                          /*
                                                          Navigator.pop(
                                                              context);
                                                          await ApiService
                                                              .instance!
                                                              .signInAnon();
                                                              */
                                                        },
                                                        child:
                                                            const Text('Yes'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            : null;
                                  },
                                  child: const Text(
                                    "Explore",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        color: Colors.black),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
