import 'dart:async';

import 'package:coast_terminal/home/const_widgets/post_button.dart';
import 'package:coast_terminal/home/const_widgets/sign_out_button.dart';
import 'package:coast_terminal/home/heart.dart';
import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:coast_terminal/post_page/post_page_provider/post_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../constants/boxes.dart';
import '../post_page/post_page.dart';
import '../post_page/post_page_provider/post_provider.dart';
import '../api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int remainingTime;
  void initState() {
    remainingTime = 0;
    startTimer();
    super.initState();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      // Calculate the remaining time in seconds
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
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        builder: (context, child) => Consumer<HomeProvider>(
              builder: (context, algo, child) => PageView(
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  print("page has been changed");
                },
                reverse: true,
                controller: ApiService.instance!.pageController,
                scrollDirection: Axis.vertical,
                children: [
                  Scaffold(
                    backgroundColor: Color.fromARGB(255, 39, 47, 62),
                    appBar: AppBar(
                      backgroundColor: Color.fromARGB(255, 56, 62, 78),
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                    ),
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(
                            flex: 20,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2,
                              child: Container(
                                color: Colors.red,
                                child: Heart(),
                              )),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(style:TextStyle(color: Colors.white),
                                  '${remainingTime ~/ 3600}:${(remainingTime % 3600) ~/ 60}:${remainingTime % 60}'),
                              Spacer(),
                              PostButton(),
                              Spacer(),
                              SignOutButton(),
                              Spacer()
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  ),
                  PostPage()
                ],
              ),
            ));
  }
}
