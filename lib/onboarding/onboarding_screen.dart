import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/consent/consent_page.dart';
import 'package:coast_terminal/constants/boxes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return SafeArea(
      top: false,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.white,
        toolbarHeight: 0.5,
        
      ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                  flex: 100,
                  child: Container(
                    // color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                     
                          Flexible(
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              elevation: 4,
                              color: Color.fromARGB(255, 10, 10, 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 350,
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
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                radius: 30,
                                                foregroundImage: ApiService
                                                    .instance!.iconReferences[3]),
                                                    Text("data")
                                          ],
                                        ),
                                        Flexible(
                                            flex: 3,
                                            child: SingleChildScrollView(
                                              child: AnimatedTextKit(
                                                  onFinished: () {
                                                    setState(() {
                                                      doneanim = true;
                                                    });
                                                  },
                                                  animatedTexts: [
                                                    TyperAnimatedText(
                                                        "Does anyone know where I can get a juul on campus. I will pay extra,Does anyone know where I can get a juul on campus. I will pay extra,Does anyone know where I can get a juul on campus. I will pay extra,Does anyone know where I can get a juul on campus. I will pay extra,Does anyone know where I can get a juul on campus. I will pay extra",
                                                        textStyle:
                                                            const TextStyle(
                                                                fontFamily:
                                                                    "Roboto",
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 25))
                                                  ]),
                                            )),
                                        Flexible(
                                            child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Icon(
                                                color: Colors.white,
                                                Icons.remove_red_eye_outlined),
                                            Text(
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                "7/10"),
                                            const Spacer(),
                                            ChoiceChip(
                                              // backgroundColor: Colors.black,
                                              //    backgroundColor: algo.isLikeSelected ? Colors.black : Colors.white,
                                              elevation: 4,
                                              avatar: const Icon(
                                                  color: Colors.green,
                                                  Icons.thumb_up),
                                              label: Text(
                                                  '5' /*Boxes
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
                                                 backgroundColor: Colors.black,
                                                elevation: 0,
                                                selectedColor: Colors.transparent,
                                              onSelected: (value) async {},
                                             avatar: const Icon(
                                                    color: Colors.red,
                                                    Icons.thumb_down),
                                                label: Text(
                                                    '1',style: TextStyle(color: Colors.white), /*Boxes
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
                            ),
                          ),
                          //   AnimatedPositioned(child: Container(width:100,height:100,color: Colors.red,), duration: Duration(seconds: 2),left: doneanim ? 50 : 10 ,)
                        ],
                      ),
                    ),
                  )),
              Expanded(
                flex: 50,
                child: Container(
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
              ),
            ],
          ),
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
        title: const Text('Terms of Service'),
      ),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* const Text(
                  'Terms of Service',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/
                const SizedBox(height: 16.0),
                const Text(
                  'Introduction',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Welcome to Edulink! We're delighted to have you as a user of our mobile application. These Terms of Service govern your use of our app, so please take a moment to read them carefully. By accessing or using our app, you agree to be bound by these Terms. If you have any questions or concerns, please don't hesitate to contact us. Thank you for choosing Edulink!",
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
                        "To foster and cultivate our vibrant community of local students, we wholeheartedly encourage you to accept our invitation to join our dedicated Discord server. By becoming a part of our community, you gain a platform to share valuable suggestions, recommendations, and reports, contributing to the growth and betterment of our collective experience. We warmly invite you to engage with fellow students, exchange ideas, and actively participate in shaping our community to meet your needs and aspirations. Together, let's create an environment that supports and empowers every member of our student community.",
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
                  "We strive to maintain a respectful and inclusive community within our app. We encourage all users to exercise diligence and ensure that their interactions and messages adhere to appropriate standards of conduct. It is important to remember that any message or content shared within the app should always be respectful, considerate, and free from any form of harassment, discrimination, or explicit material.\n\nPlease be aware that we have implemented measures to protect the integrity and safety of our community. In the event that a message is flagged as inappropriate, our backend systems may store relevant information, including the message content and IP address, for further investigation and appropriate action. This is done to uphold the wellbeing and experience of all users and to enforce our community guidelines.\n\nWe kindly request all users to act responsibly, treat others with respect, and engage in constructive conversations. By fostering an environment of mutual respect and appropriate behavior, we can collectively create a positive and valuable experience for every member of our community.",
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
                  "As part of our commitment to providing you with the best possible experience, our app may display advertisements tailored to your interests. These personalized ads are designed to deliver content that is relevant and engaging to you. By analyzing your app usage patterns and preferences, we can show you ads that align with your potential interests and needs.\n\nIf you are a resident of California, you have the option to opt out of personalized ads as per the California Consumer Privacy Act (CCPA). By exercising this choice, you can limit the collection and use of your personal information for targeted advertising purposes. Please note that opting out of personalized ads does not mean you will stop seeing ads altogether; it means the ads you see may be less relevant to your specific interests. It's important to note that by default, our app serves personalized ads to all users. This enables us to generate revenue necessary for sustaining and improving our services.\n\nAdditionally, personalized ads help us offer you a more customized and engaging experience. We respect your privacy and understand the significance of providing transparency and control over your personal data. You can review our Privacy Policy for detailed information on data collection, usage, and your rights. We appreciate your understanding and support as we continue to enhance our app and deliver valuable services to you.",
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
