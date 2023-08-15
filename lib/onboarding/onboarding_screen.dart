import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/consent/consent_page.dart';
import 'package:coast_terminal/constants/boxes.dart';
import 'package:coast_terminal/onboarding/check_provider/check_provider.dart';
import 'package:coast_terminal/onboarding/onboarding_provider/onboarding_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  /*
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
    return null;
  }
*/
  late PageController? _pageController;
 //Map possibleMessages = {"mes1":{"title":"I could use some advice in the gym. I highkey have no clue what I'm doing","index":}}
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
  @override
  void initState() {
    //  loadAd();
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  bool doneanim = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingProvider(),
      builder: (context, child) => Consumer<OnboardingProvider>(
        builder: (context, algo, child) => SafeArea(

          top: false,
          bottom: false,
          right: false,
          left: false,
          child: algo.hasCertificate ? Scaffold(
            appBar: AppBar(
              shadowColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.white,
              toolbarHeight: 16,
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Eduboard",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.generating_tokens,color: const Color.fromARGB(255, 177, 159, 0),),
                      Text("Coins: ${Boxes.getRootUser().get('CurrentRootUser')!.coins}",style: TextStyle(fontFamily: "OpenSans",color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  )
                /*  GestureDetector(
                    onTap: (){
                      Platform.isAndroid ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const TOS();
                      },)) : Navigator.push(context, CupertinoPageRoute(builder: (context) {
                        return const TOS();
                      },));
                    },
                    child: const Text(
                      "Terms",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Flexible(
                     flex: 50,
                      child: Container(
                        //     color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: algo.currentMes != null ? Card(
                                  
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  elevation: 4,
                                  color: const Color.fromARGB(255, 10, 10, 10),
                                  child: Stack(
                                    children: [
                                    //  Image.asset("assets/Wallpaper.png",fit: BoxFit.fitHeight,),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                      //  height: 350,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              Colors.transparent,
                                                          radius: 30,
                                                          foregroundImage: ApiService
                                                              .instance!
                                                              .iconReferences[algo.currentMes!["Icon"]]),
                                                
                                                       FittedBox(child: Text(algo.currentMes!["Title"].toString(),style: const TextStyle(fontFamily: "OpenSans",color:Colors.white,fontSize: 42),maxLines: 2,))
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                    flex: 3,
                                                    child: SingleChildScrollView(
                                                      child: AnimatedTextKit(totalRepeatCount: 1,
                                                          onFinished: () {
                                                            setState(() {
                                                              doneanim = true;
                                                            });
                                                          },
                                                          animatedTexts: [
                                                            TyperAnimatedText(
                                                                algo.currentMes!["Message"],
                                                                textStyle: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "OpenSans",
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 32),
                                                                textAlign:
                                                                    TextAlign.left)
                                                          ]),
                                                    )),
                                                Flexible(
                                                    child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    const Icon(
                                                        color: Colors.white,
                                                        Icons
                                                            .remove_red_eye_outlined),
                                                     Text(
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                       algo.currentMes!["Views"].toString()),
                                                    const Spacer(),
                                                    ChoiceChip(
                                                      // backgroundColor: Colors.black,
                                                      //    backgroundColor: algo.isLikeSelected ? Colors.black : Colors.white,
                                                      elevation: 4,
                                                      avatar: const Icon(
                                                          color: Colors.green,
                                                          Icons.thumb_up),
                                                      label:  Text(
                                                          algo.currentMes!["Likes"].toString()/*Boxes
                                                                                      .getMessage()
                                                                                  .get(
                                                                                      'currentMessage')!
                                                                                  .likes
                                                                                  .toString()*/
                                                          ),
                                                      selected: false,
                                                      onSelected: (value) async {},
                                                      selectedColor: Colors.white,
                                                    ),
                                                    ChoiceChip(
                                                        disabledColor: Colors.red,
                                                        backgroundColor:
                                                            Colors.black,
                                                        elevation: 0,
                                                        selectedColor:
                                                            Colors.transparent,
                                                        onSelected:
                                                            (value) async {},
                                                        avatar: const Icon(
                                                            color: Colors.red,
                                                            Icons.thumb_down),
                                                        label:  Text(
                                                          algo.currentMes!["Dislikes"].toString(),
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white), /*Boxes
                                                                                      .getMessage()
                                                                                  .get(
                                                                                      'currentMessage')!
                                                                                  .dislikes
                                                                                  .toString()*/
                                                        ),
                                                        selected: false),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                         : const CircularProgressIndicator()     ),
                              //   AnimatedPositioned(child: Container(width:100,height:100,color: Colors.red,), duration: Duration(seconds: 2),left: doneanim ? 50 : 10 ,)
                            ],
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 70,
                      child: Container(
                          //  color: Colors.green,width: MediaQuery.of(context).size.width,
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: AnimatedTextKit(
                                  onNext: (p0, p1) {
                                    //print(p0);

                                    // algo.changeTitles(p0++);
                                    algo.changeTitles(p0);
                                  },
                                  repeatForever: true,
                                  onNextBeforePause: (p0, p1) {
                                    print(p0);
                                    algo.switchMessage(p0);
                                  },
                                  animatedTexts: <FadeAnimatedText>[
                                    FadeAnimatedText(
                                        fadeInEnd: .04,
                                        duration: const Duration(seconds: 10),
                                        "Kill time on campus",
                                        textStyle: const TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 32)),
                                    FadeAnimatedText(
                                        fadeInEnd: .04,
                                        duration: const Duration(seconds: 10),
                                        "No sign up required",
                                        textStyle: const TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 32)),
                                    FadeAnimatedText(
                                        fadeInEnd: .04,
                                        duration: const Duration(seconds: 10),
                                        "Join the community",
                                        textStyle: const TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 32))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(algo.subHeading),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: algo.firstCircle,
                                      shape: BoxShape.circle)),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: algo.secondCircle,
                                      shape: BoxShape.circle)),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: algo.thirdCircle,
                                      shape: BoxShape.circle))
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
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
                                              Colors.black),
                                      overlayColor:
                                          MaterialStateProperty.all(null)),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ChangeNotifierProvider(
                                          create: (context) => CheckProvider(),
                                          builder: (context, child) =>  Consumer<CheckProvider>(
                                            builder: (context, algo2, child) => WillPopScope(
              onWillPop: () async => algo2.popScope,

                                              child: AlertDialog(
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
                                                                      Color.fromARGB(255, 0, 0, 0)),
                                                              foregroundColor:
                                                                  const MaterialStatePropertyAll(
                                                                      Colors.white),
                                                              shape: MaterialStatePropertyAll(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(20)))),
                                                          onPressed: () async {
                                                            //Navigator.pop(context);
                                                            if(algo2.progLoad != true)
                                                            {
                                                         await        algo2.check2(context);

                                                            }
                                            
                                                          },
                                                          child:  algo2.progLoad == true ? const SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: Colors.grey,),):Text(algo2.preButton)))
                                                ],
                                                //alignment: Alignment.center,
                                                                                    
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Text(
                                                        "But first, we need to check the following",
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ),
                                                    const SizedBox(height:8),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: 20,
                                                            height: 20,
                                                            child:
                                                          algo2.locationPass == true ?   const Icon(Icons.check,color:Colors.green) : algo2.locationPass == null ?   const CircularProgressIndicator() :   const Icon(Icons.error,color:Colors.red) ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        FittedBox(
                                                          child: algo2.locationPass == false ? const Text("1. Make sure location is on\n2. Is \"Precise\" enabled?"): const Text("Location") ,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: 20,
                                                            height: 20,
                                                            child:
                                                                 algo2.adPass == true ?   const Icon(Icons.check,color:Colors.green) : algo2.adPass == null ?   const CircularProgressIndicator() :   const Icon(Icons.error,color:Colors.red)),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        const Text("Load Ad")
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                 RichText(textAlign: TextAlign.center,
            text: TextSpan(
              text: 'By pressing "Continue", you agree to ',
              style: const TextStyle(
                
                color: Colors.black,
                fontSize: 16.0,
              ),
              children: [
                TextSpan(
                  text: 'our terms',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:TapGestureRecognizer()
                    ..onTap = () {
                      // Handle the terms link tap here
                       Platform.isAndroid ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const TOS();
                      },)) : Navigator.push(context, CupertinoPageRoute(builder: (context) {
                        return const TOS();
                      },));
                    },
                ),
              ],
            ),)
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(20)),
                                                title: const Text(
                                                  "You are about to enter Eduboard",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "OpenSans"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const FittedBox(
                                    child: Text(
                                      "Get Started",
                                      style: TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          color: Colors.white),
                                    ),
                                  ))),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text("Beta: 0.0.1"),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ))
                      /*Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 10, 10, 10),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
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
                                            MaterialStateProperty.all(Colors.white),
                                        overlayColor:
                                            MaterialStateProperty.all(Colors.grey)),
                                    onPressed: () {
                                      if (Boxes.getCertificate()
                                              .get('currentCert') !=
                                          null) {
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
                                                              Navigator.pop(
                                                                  context);
                                                              await ApiService
                                                                  .instance!
                                                                  .signInAnon();
                                                              /*
                                                            await _rewardedAd!.show(
                                                              onUserEarnedReward:
                                                                  (ad, reward) {
                                                                print(
                                                                    "here is your award");
                                                              },
                                                            );*/
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
                                                        title:
                                                            const Text("Hold on!"),
                                                        content: const Text(
                                                            "To support the maintenance and improvement of the app's quality, users are kindly requested to watch an ad. By doing so, users contribute to the sustainability of the app's development and its ability to provide its services."),
                                                        actions: <CupertinoDialogAction>[
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
                          /*
                                                            await _rewardedAd!.show(
                                                              onUserEarnedReward:
                                                                  (ad, reward) {
                                                                print(
                                                                    "here is your award");
                                                              },
                                                            );*/
                          
                                                              Navigator.pop(
                                                                  context);
                                                              await ApiService
                                                                  .instance!
                                                                  .signInAnon();
                                                            },
                                                            child:
                                                                const Text('Yes'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  )
                                                : null;
                                      } else {
                                        Platform.isIOS
                                            ? Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const ConsentPage(),
                                                ))
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ConsentPage(),
                                                ));
                                      }
                                    },
                                    child: const FittedBox(
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40,
                                            color: Colors.black),
                                      ),
                                    ))),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text(
                                  "By tapping Get Started, you agree to your",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          Platform.isIOS
                                              ? CupertinoPageRoute(
                                                  builder: (context) => const TOS(),
                                                )
                                              : MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TOS()));
                                    },
                                    child: const Text(
                                      "Terms • Privacy Policy",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                             */
                      ),
                ],
              ),
            ),
          ): ConsentPage()
        
        ),
      ),
    );
  }
}

class TOS extends StatelessWidget {
  const TOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
               shadowColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.close,color: Colors.black,),
                onPressed: () {
                Navigator.pop(context);
                },
              ),
              title:  const Text("Terms of Service",style: TextStyle(fontFamily: "OpenSans",color:Colors.black,fontWeight:FontWeight.bold)),
            ),
      body: Scrollbar(
        
        child: Padding(
          padding: EdgeInsets.only(left: 16.0,right:16.0),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 32),
                            "Summary:"),
                        Text(
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 16),
                            "At this time (Beta: 0.0.1), the app is only functional at the following campus's:\n\nOrange Coast College\nGolden West College\n\nAlthough some safety measures have been taken when posting messages, you (as the user) are responsible and are expected to be held accountable for your posts. The goal of this app is to eventually become inclusive to all students who can find this app'sfeatures fun to use.\n\nBefore entering Eduboard you are required to let us verify you are on a supported campus as well as finish watching an ad.")
                      ],
                    ),
                  )
                  /* const Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  ,
                  SizedBox(height: 16.0),
                  const Text(
                    'Introduction',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Welcome to Eduboard! We're delighted to have you as a user of our mobile application. These Terms of Service govern your use of our app, so please take a moment to read them carefully. By accessing or using our app, you agree to be bound by these Terms. If you have any questions or concerns, please don't hesitate to contact us via Discord. Thank you for choosing Edulink!",
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Community',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  RichText(
                    text: TextSpan(
                      text:
                          "To foster and cultivate our community of local students, we wholeheartedly encourage you to accept our invitation to join our dedicated Discord server. By becoming a part of our community, you gain a platform to share valuable suggestions, recommendations, and reports, contributing to the growth and betterment of our collective experience. We warmly invite you to engage with fellow students, exchange ideas, and actively participate in shaping our community to meet your needs and aspirations. Together, let's create an environment that supports and empowers every member of our student community.",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          onEnter: (event) {
                            print(event);
                          },
                          text: ' Discord link here',
                          recognizer: TapGestureRecognizer()
                                                    ..onTap = ()async{
                                                                     
                                final Uri _url =
                                    Uri.parse('https://discord.gg/4Khfd2rHUk');
                                if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                }
                                                    },
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(
                          text: ' consectetur adipiscing elit.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Diligence and Appropriate Behavior',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "We strive to maintain a respectful and inclusive community within our app. We encourage all users to exercise diligence and ensure that their interactions and messages adhere to appropriate standards of conduct. It is important to remember that any message or content shared within the app should always be respectful, considerate, and free from any form of harassment, discrimination, or explicit material.\n\nIf you see something you don't like,screenshot it and report it! This is the responsiblity of the user.\n\nWe kindly request all users to act responsibly, treat others with respect, and engage in constructive conversations. By fostering an environment of mutual respect and appropriate behavior, we can collectively create a positive and valuable experience for every member of our community.",
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Mobile Ads and Personalization',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "In order for us to do what we do we have implemented ads.\nBecause of this, users (by defualt) opt in for CPRA (California Privacy Rights Act). Basicaly this allows us to make the maximum return off the ads displayed when using this app. As part of our commitment to providing you with the best possible experience, our app may display advertisements tailored to your interests. These personalized ads are designed to deliver content that is relevant and engaging to you. By analyzing your app usage patterns and preferences, we can show you ads that align with your potential interests and needs.\n\nIf you are a resident of California, you have the option to opt out of personalized ads as per the California Consumer Privacy Act (CCPA). By exercising this choice, you can limit the collection and use of your personal information for targeted advertising purposes. Please note that opting out of personalized ads does not mean you will stop seeing ads altogether; it means the ads you see may be less relevant to your specific interests. It's important to note that by default, our app serves personalized ads to all users. This enables us to generate revenue necessary for sustaining and improving our services.\n\nAdditionally, personalized ads help us offer you a more customized and engaging experience. We respect your privacy and understand the significance of providing transparency and control over your personal data. You can review our Privacy Policy for detailed information on data collection, usage, and your rights. We appreciate your understanding and support as we continue to enhance our app and deliver valuable services to you.",
                  ),
                  const SizedBox(height: 8.0),
                 
                ],
              ),
            ),
          ),
        ),
      )
 ,
    );
}
}
