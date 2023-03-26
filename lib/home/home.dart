import 'dart:async';

import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:coast_terminal/post_page/post_page_provider/post_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../post_page/post_page.dart';
import '../post_page/post_page_provider/post_provider.dart';
import '../api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                          FutureBuilder(
                              future: algo.calculate(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData == false) {
                                  return Text("No data");
                                } else if (snapshot.hasData == true) {
                                  print(snapshot.data);
                                  return Text("has data");
                                }
                                return Text("error");
                              }),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 254, 44, 117)),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 254, 44, 117)),
                                    overlayColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 255, 34, 111))),
                                onPressed: () {
                                  ApiService.instance!.pageController.nextPage(duration: Duration(milliseconds:500), curve: Curves.linear).then((value) {
                                     
                                  });
                              
                                /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        maintainState: true,
                                        builder: (context) => PostPage(),
                                      )
                                      );*/
                                },
                                child: Text(
                                  "Post",
                                  style: Theme.of(context).textTheme.labelLarge,
                                )),
                          ),
                          TextButton(
                              onPressed: () {
                                ApiService.instance!.signOut();
                              },
                              child: const Text("sign out"))
                        ],
                      ),
                    ),
                  ),PostPage()],
              ),
            ));
  }
}

