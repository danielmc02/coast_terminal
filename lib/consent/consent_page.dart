import 'dart:io';

import 'package:coast_terminal/consent/consent_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ConsentPage extends StatefulWidget {
  const ConsentPage({Key? key}) : super(key: key);

  @override
  State<ConsentPage> createState() => _ConsentPageState();
}

class _ConsentPageState extends State<ConsentPage> {
  @override
  void initState() {
    //print("Algo has been created now");
    super.initState();
  }

  @override
  void dispose() {
    //print("Algo has ended ");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConsentProvider(),
      child: Consumer<ConsentProvider>(
        builder: ((context, algo, child) => WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                /*   floatingActionButton:  algo.pageController.page! >= 1 == true ? FloatingActionButton(onPressed: (){
                  
                },child: Icon(Icons.arrow_back),foregroundColor: Colors.white,backgroundColor: Colors.black,) : null, 
            */
                bottomNavigationBar: BottomAppBar(
                  color: Colors.transparent,
                  shadowColor: const Color.fromARGB(0, 153, 35, 35),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: TextButton(
                              onPressed: () async {
                                if (algo.pageController.page == 0) {
                                  algo.pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                } else if (algo.pageController.page == 1 &&
                                    (algo.choseGwc == true ||
                                        algo.choseOcc == true) &&
                                    algo.hasConfirmedLocation == false) {
                                  await algo.getLocation(context);
/*
                                  algo.pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                  print(
                                      "AHSDHSHDFHS ${algo.pageController.page}");
*/
                                } else if (algo.pageController.page == 2 &&
                                    (algo.extrovertedCat != false ||
                                        algo.introvertedCat != false)) {
                                  print("1");
                                  algo.pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                } else if (algo.pageController.page == 3) {
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
                                                                  Colors.green),
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
                                                        await algo
                                                            .finishConsent();

                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("Okay")))
                                            ],
                                            //alignment: Alignment.center,

                                            content: const Text(
                                              "To support the maintenance and improvement of the app's quality, users are kindly requested to watch an ad. By doing so, users contribute to the sustainability of the app's development and its ability to provide its services.",
                                              textAlign: TextAlign.center,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            title: const Text(
                                              "Almost there",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ));

/*
                                  print(
                                      "SDFSDFSDONNSOSNSIONIONFIOSNFIOFSNISDFN");
                                  await algo.finishConsent();
                                  Navigator.pop(context, "");*/
                                }
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              child: Text(
                                algo.buttonTitle,
                                style: const TextStyle(fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  shadowColor: const Color.fromARGB(0, 246, 246, 246),
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  foregroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  title: FittedBox(
                      child: Text("on",
         //        algo.pageController.page == 1 ?   "TOS" : " ", //algo.headerTitle,
                    style: const TextStyle(fontFamily: "OpenSans",
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
                ),
                body: Column(
                  children: [
                    /* Expanded(
                  flex: 3,child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(color: Colors.red,width: MediaQuery.of(context).size.width,)
                            ],
                ))*/

                    Expanded(
                      flex: 1,
                      child: FutureBuilder(
                        future: Future.value(false),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AnimatedBuilder(
                                animation: algo.pageController,
                                builder: (context, child) {
                                  return LinearProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                      color: algo.choseGwc
                                          ? Colors.green
                                          : Colors.orange,
                                      semanticsLabel:
                                          "Sign Up Progress Indicator",
                                      value:
                                          (algo.pageController.page ?? 0) / 3);
                                });
                          } else {
                            return Container(
                              color: Colors.transparent,
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 100,
                      child: Container(
                        //color: Colors.grey,
                        child: PageView(
                        //  physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (value) {
                            if (value == 3) {
                              setState(() {
                                algo.isOnLastPage = true;
                              });
                            }
                            print("Page is $value");
                            algo.changeTitle(value);
                          },
                          controller: algo.pageController,
                          children: const [
                            FirstPage(),
                         CollegePickPage(),
                        //    SecondPage(),
                            ThirdPage()
                            /*
                            FirstPage(),
                            SecondPage(),
                            ThirdPage(),
                            ForthPage()*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class CollegePickPage extends StatelessWidget {
  const CollegePickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsentProvider>(
      builder: (context, algo, child) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      algo.chooseSchool("gwc");
                    },
                    child: Card(
                      elevation: algo.choseGwc ? 6 : 0,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 60,
                          child: FittedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FittedBox(
                                    fit: BoxFit.contain,
                                    child: Stack(
                                      children: [
                                        ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            algo.choseGwc
                                                ? Colors.transparent
                                                : Colors.black,
                                            BlendMode.saturation,
                                          ),
                                          child: const CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              foregroundImage: AssetImage(
                                                  "assets/school_logos/gwc.png")),
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Golden West College",
                                  style: TextStyle(fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      algo.chooseSchool("occ");
                    },
                    child: Card(
                      elevation: algo.choseOcc ? 6 : 0,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 60,
                          child: FittedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FittedBox(
                                    fit: BoxFit.contain,
                                    child: Stack(
                                      children: [
                                        ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            algo.choseOcc
                                                ? Colors.transparent
                                                : Colors.black,
                                            BlendMode.saturation,
                                          ),
                                          child: const CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              foregroundImage: AssetImage(
                                                  "assets/school_logos/occ.jpg")),
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Orange Coast College",
                                  style: TextStyle(fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FittedBox(
                        child: Text(
                      "School Confirmation",
                      style: TextStyle(fontFamily: "OpenSans",
                          color: Colors.black,
                          fontSize: 42,
                          fontWeight: FontWeight.bold),
                    )),
                    Text(
                        "Instead of creating an account, we only ask users to confirm their campus to direct them to the relevant channels. Simply select your campus, click \"Confirm,\" and grant temporary location access for verification. Being physically present on campus during confirmation is necessary. We value your privacy and security, and your location data won't be stored or shared beyond verifying your campus affiliation.")
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsentProvider>(
      builder: (context, value, child) => Container(
       // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to\nEdubored",
                  style: TextStyle(fontFamily: "OpenSans",
                      fontSize: 42, fontWeight: FontWeight.bold),
                ),  const SizedBox(
                        height: 40,
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.red,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: Icon(
                              Icons.school,
                              size: 72,
                              color: Colors.blue,
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FittedBox(
                                      child: Text(
                                    "Network with students",
                                    style: TextStyle(fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                                  Text(
                                    "Exclusively for students at Orange Coast and Golden West College",
                                    style: TextStyle(fontFamily: "OpenSans",fontSize: 15),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        // color: Colors.red,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: Icon(
                              Icons.chat_sharp,
                              size: 72,
                              color: Colors.green,
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                      child: Text(
                                    "Interactive Posts",
                                    style: TextStyle(fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                                  Text(
                                    "Made for when you get bored",
                                    style: TextStyle(fontFamily: "OpenSans",fontSize: 15),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        // color: Colors.red,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: Icon(
                              Icons.discord,
                              size: 72,
                              color: Color.fromARGB(255, 84, 99, 235),
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                      child: Text(
                                    "Join the community",
                                    style: TextStyle(fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                                  Text(
                                    "For students, by students. Join the discord to show your support",
                                    style: TextStyle(fontFamily: "OpenSans",fontSize: 15),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsentProvider>(
      builder: (context, algo, child) => SizedBox(
        width: MediaQuery.of(context).size.width,
        //  color: Colors.pink,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "This will be used to show you a chat that is in your interest",
              style: TextStyle(fontFamily: "OpenSans",fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Flexible(
              child: /*ListView(
                children: [
                   cardView("assets/card_images/study.jpg"),cardView("assets/card_images/gym.jpeg"),
                    cardView("assets/card_images/buisness.jpeg"),cardView("assets/card_images/gaming.jpeg")
                ],
              )*/

                  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: cardView(
                          context,
                          "assets/card_images/study.jpg",
                          algo.extrovert,
                          1,
                          algo.extrovertedCat == true ? true : false),
                    ),
                    Flexible(
                      child: cardView(
                          context,
                          "assets/card_images/gym.jpeg",
                          algo.introvert,
                          2,
                          algo.introvertedCat == true ? true : false),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget cardView(BuildContext context, String url, List<String> parameters,
    int index, bool val) {
  return Consumer<ConsentProvider>(
    builder: (context, algo, child) => GestureDetector(
      onTap: () async {
        await algo.pickedCategory(index);
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          val ? Colors.transparent : Colors.black,
          BlendMode.saturation,
        ),
        child: Card(
          elevation: val ? 9 : 0,
          color: Colors.red,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SizedBox(
            width: 200,
            height: 200,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(fit: BoxFit.fill, url),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        for (String e in parameters)
                          Text(e,
                              style: const TextStyle(fontFamily: "OpenSans",
                                  color: Colors.white, fontSize: 24))

                        /*  Flexible(
                          child: ListView.builder(itemCount: parameters.length,itemBuilder: (context, index) {
                          return Text(parameters[index]);                  },),
                        )*/
                      ],
                    )
                    /*        Container(
                      color: Colors.red,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Center(
                              child: ListView.builder( physics: AlwaysScrollableScrollPhysics(),
                                itemCount: parameters.length,
                                itemBuilder: (context, index) {
                                  return Text(parameters[index]);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )*/
                  ],
                )),
          ),
        ),
      ),
    ),
  );
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState() {
    print("Second page created");
    _init();
    super.initState();
  }

  _init() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsentProvider>(
      builder: (context, algo, child) => Scrollbar(
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
                  "Welcome to Eduboard! We're delighted to have you as a user of our mobile application. These Terms of Service govern your use of our app, so please take a moment to read them carefully. By accessing or using our app, you agree to be bound by these Terms. If you have any questions or concerns, please don't hesitate to contact us. Thank you for choosing Edulink!",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Checkbox(
                      value: algo.optInCCPA,
                      onChanged: (value) async {
                        //  final status = await AppTrackingTransparency.requestTrackingAuthorization();

                        setState(() {
                          algo.optInCCPA = value;
                        });
                      },
                    ),
                    Text(
                        "I (as the user) opt ${algo.optInCCPA == true ? "in" : "out"} for CCPA"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
