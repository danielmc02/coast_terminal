import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/main.dart';
import 'package:coast_terminal/onboarding/onboarding_provider/onboarding_provider.dart';
import 'package:coast_terminal/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Consumer<OnboardingProvider>(
      builder: ((context, algo, child) => WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              /*   floatingActionButton:  algo.pageController.page! >= 1 == true ? FloatingActionButton(onPressed: (){
                
              },child: Icon(Icons.arrow_back),foregroundColor: Colors.white,backgroundColor: Colors.black,) : null, 
          */
              bottomNavigationBar: algo.hasConsented ? Row(
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
                                if (algo.hasConsented) {
                                  algo.createRootUser();
                                } else {}
                              } else if (algo.pageController.page == 1) {
                                print("AT TOS");
                                await algo.pageController.previousPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeOutSine);
                                algo.changeTitle(0);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: algo.hasConsented == true
                                    ? MaterialStatePropertyAll(Colors.black)
                                    : MaterialStatePropertyAll(Colors.grey),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            child: Text(
                              algo.buttonTitle,
                              style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                
              )
: null
              /*       appBar: AppBar(
                automaticallyImplyLeading: false,
                shadowColor: const Color.fromARGB(0, 246, 246, 246),
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                foregroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                title: FittedBox(
                    child: Text(
                  "on",
                  //        algo.pageController.page == 1 ?   "TOS" : " ", //algo.headerTitle,
                  style: const TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),*/
           ,   body: PageView(controller: algo.pageController,children: [FirstPage(),ThirdPage()]),
            ),
          )),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, algo, child) => Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child: 
    Column(
      children: [
        Expanded(flex: 25,child: Container(
          width: MediaQuery.of(context).size.width,
         
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                          "Welcome to\nEdubored",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 42,
                              fontWeight: FontWeight.bold),
                        ),
            ),
          ],
        ),)),
                Expanded(flex: 90,child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Spacer(flex: 16,),
                                    Container(
                                          decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            const Color.fromARGB(255, 44, 44, 44)),
                                    borderRadius: BorderRadius.circular(20)),
                              //   color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                              child: Text(
                                            "Interact with students",
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                          Text(
                                            "Exclusively for students at Orange Coast and Golden West College",
                                            style: TextStyle(
                                                fontFamily: "OpenSans", fontSize: 15),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                         Spacer(flex: 16,),
                            Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            const Color.fromARGB(255, 44, 44, 44)),
                                    borderRadius: BorderRadius.circular(20)),
                              // color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                              child: Text(
                                            "Interactive Posts",
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                          Text(
                                            "Made for when you get bored on campus and have nothing better to do",
                                            style: TextStyle(
                                                fontFamily: "OpenSans", fontSize: 15),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Spacer(flex: 16,),
                            GestureDetector(
                              onTap: () async {
                                print("TAPED");
                                final Uri _url =
                                    Uri.parse('https://discord.gg/4Khfd2rHUk');
                                if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            const Color.fromARGB(255, 44, 44, 44)),
                                    borderRadius: BorderRadius.circular(20)),
                                // color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                                child: Text(
                                              "Join the community",
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                            Text(
                                              "For students, by students. Join the discord to show your support",
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(flex: 16,),
                               
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.black,
                                    ),
                                    width: MediaQuery.of(context).size.width / 1.2,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          side: BorderSide(
                                              color: Colors.white, width: 2),
                                          value: algo.hasConsented,
                                          onChanged: (value) {
                                          algo.hasConsented = value!;
                                        algo.passConsentCorrection(value);
                                          },
                                        ),
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "I have read and agree to the ",
                                                ),
                                                TextSpan(
                                                    text: "Terms & Service",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      decoration:
                                                          TextDecoration.underline,
                                                    ),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        print("TAPPED");
                            await algo.pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeOutSine)    ;                                          
                                                      }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                           
                    ],
                  ),
                ),))
      ],
    ))
   );
  }
}

/*
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
                              style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  color: Colors.white,
                                  fontSize: 24))

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
*/
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
    return Consumer<OnboardingProvider>(
      builder: (context, algo, child) => Scrollbar(
        
        child: Padding(
          padding: EdgeInsets.only(left: 16.0,right:16.0,top: 40),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Terms of service",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 42,
                        fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
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
                            "At this time (Beta: 0.0.1), the app is only functional at the following campus's:\n\nOrange Coast College\nGolden West College\n\nAlthough some safety measures have been taken when posting messages, you (as the user) are responsible and are expected to be held accountable for your posts. The goal of this app is to eventually become inclusive to all students who can find this app'sfeatures fun to use.\n\nBefore entering Edubored you are required to let us verify you are on a supported campus as well as finish watching an ad.")
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
                    "We strive to maintain a respectful and inclusive community within our app. We encourage all users to exercise diligence and ensure that their interactions and messages adhere to appropriate standards of conduct. It is important to remember that any message or content shared within the app should always be respectful, considerate, and free from any form of harassment, discrimination, or explicit material.\n\nIf you see something you don't like, screenshot it and report it! This is the responsiblity of the user.\n\nWe kindly request all users to act responsibly, treat others with respect, and engage in constructive conversations. By fostering an environment of mutual respect and appropriate behavior, we can collectively create a positive and valuable experience for every member of our community.",
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
      ),
    );
  }
}
