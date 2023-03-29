import 'dart:async';

import 'package:coast_terminal/home/const_widgets/post_button.dart';
import 'package:coast_terminal/home/const_widgets/sign_out_button.dart';
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
                        children: [Spacer(flex: 20,),
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
                              }),Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [Spacer(flex:6),
                                                 PostButton(),Spacer(flex: 2,),
                  SignOutButton(),Spacer()
                                ],
                              ),Spacer()
           
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
