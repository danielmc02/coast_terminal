import 'package:platform/platform.dart';
import 'package:coast_terminal/consent/consent_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
        builder: ((context, algo, child) => Scaffold(
              bottomNavigationBar: algo.choseGwc || algo.choseOcc
                  ? BottomAppBar(
                      color: Colors.transparent,
                      shadowColor: const Color.fromARGB(0, 153, 35, 35),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 50,
                            child: TextButton(
                                onPressed: () {
                                  algo.pageController.nextPage(
                                      duration: Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                child: Text(
                                  "Next",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    )
                  : null,
              appBar: AppBar(
                shadowColor: Color.fromARGB(0, 246, 246, 246),
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                foregroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                title: FittedBox(
                    child: Text(
                  "What school do you go to?",
                  style: GoogleFonts.openSans(
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
                                    color: Theme.of(context).primaryColor,
                                    semanticsLabel:
                                        "Sign Up Progress Indicator",
                                    value: (algo.pageController.page ?? 0) / 3);
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
                        onPageChanged: (value) {},
                        controller: algo.pageController,
                        children: [
                          Container(
                            //color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    algo.chooseSchool("gwc");
                                  },
                                  child: Card(
                                    elevation: algo.choseGwc ? 6 : 0,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        height: 60,
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Stack(
                                                    children: [
                                                      ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          algo.choseGwc
                                                              ? Colors
                                                                  .transparent
                                                              : Colors.black,
                                                          BlendMode.saturation,
                                                        ),
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            foregroundImage:
                                                                AssetImage(
                                                                    "assets/school_logos/gwc.png")),
                                                      ),
                                                    ],
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "Golden West College",
                                                style: GoogleFonts.openSans(
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
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        height: 60,
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Stack(
                                                    children: [
                                                      ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          algo.choseOcc
                                                              ? Colors
                                                                  .transparent
                                                              : Colors.black,
                                                          BlendMode.saturation,
                                                        ),
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            foregroundImage:
                                                                AssetImage(
                                                                    "assets/school_logos/occ.jpg")),
                                                      ),
                                                    ],
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "Orange Coast College",
                                                style: GoogleFonts.openSans(
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
                          SecondPage()
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
            )),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool? optOutCCPA = true;

  void initState() {
    print("Second page created");
    _init();
    super.initState();
  }

  _init() {}

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Terms of Service',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Introduction',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Welcome to Edulink! We're delighted to have you as a user of our mobile application. These Terms of Service govern your use of our app, so please take a moment to read them carefully. By accessing or using our app, you agree to be bound by these Terms. If you have any questions or concerns, please don't hesitate to contact us. Thank you for choosing Edulink!",
                ),
                SizedBox(height: 16.0),
                Text(
                  'Community',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                RichText(

                  text: TextSpan(
                    text: "To foster and cultivate our vibrant community of local students, we wholeheartedly encourage you to accept our invitation to join our dedicated Discord server. By becoming a part of our community, you gain a platform to share valuable suggestions, recommendations, and reports, contributing to the growth and betterment of our collective experience. We warmly invite you to engage with fellow students, exchange ideas, and actively participate in shaping our community to meet your needs and aspirations. Together, let's create an environment that supports and empowers every member of our student community.",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(onEnter: (event) {
                        print(event);
                      },
                        text: ' Discord link here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' consectetur adipiscing elit.',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Diligence and Appropriate Behavior',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "We strive to maintain a respectful and inclusive community within our app. We encourage all users to exercise diligence and ensure that their interactions and messages adhere to appropriate standards of conduct. It is important to remember that any message or content shared within the app should always be respectful, considerate, and free from any form of harassment, discrimination, or explicit material.\n\nPlease be aware that we have implemented measures to protect the integrity and safety of our community. In the event that a message is flagged as inappropriate, our backend systems may store relevant information, including the message content and IP address, for further investigation and appropriate action. This is done to uphold the wellbeing and experience of all users and to enforce our community guidelines.\n\nWe kindly request all users to act responsibly, treat others with respect, and engage in constructive conversations. By fostering an environment of mutual respect and appropriate behavior, we can collectively create a positive and valuable experience for every member of our community.",
                ),                SizedBox(height: 8.0),

                 Text(
                  'Mobile Ads and Personalization',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "As part of our commitment to providing you with the best possible experience, our app may display advertisements tailored to your interests. These personalized ads are designed to deliver content that is relevant and engaging to you. By analyzing your app usage patterns and preferences, we can show you ads that align with your potential interests and needs.\n\nIf you are a resident of California, you have the option to opt out of personalized ads as per the California Consumer Privacy Act (CCPA). By exercising this choice, you can limit the collection and use of your personal information for targeted advertising purposes. Please note that opting out of personalized ads does not mean you will stop seeing ads altogether; it means the ads you see may be less relevant to your specific interests. It's important to note that by default, our app serves personalized ads to all users. This enables us to generate revenue necessary for sustaining and improving our services.\n\nAdditionally, personalized ads help us offer you a more customized and engaging experience. We respect your privacy and understand the significance of providing transparency and control over your personal data. You can review our Privacy Policy for detailed information on data collection, usage, and your rights. We appreciate your understanding and support as we continue to enhance our app and deliver valuable services to you.",
                ),
                                SizedBox(height: 8.0),
Row(
  children: [
    Checkbox(
      value: optOutCCPA,
      onChanged: (value) {
        setState(() {
                  optOutCCPA = value;

        });
      },
    ),
    Text(
      "I (as the user) opt ${optOutCCPA == true ? "in" : "out"} for CCPA"
    ),
  ],
)
              ],
            ),
          ),
      ),
     );
  }
}
