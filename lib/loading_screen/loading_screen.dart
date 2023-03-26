import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/loading_screen/provider/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    print("Loading screen initialized");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(
            create: (_) => LoadingProvider()),
      ],
      child: Consumer<LoadingProvider>(builder: (context, algo, child) {
        if (algo.finished == false) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(
                    flex: 10,
                  ),
                  //const SizedBox(width:300,height:300,child: RiveAnimation.asset(animations:,"./assets/rive_assets/movingplane.riv",fit: BoxFit.contain,)),
                  const Spacer(
                    flex: 50,
                  ),
                  AnimatedTextKit(animatedTexts: [
                    FadeAnimatedText("Loading anonymous token")
                  ]),
                  const Spacer(
                    flex: 20,
                  ),
                  const LinearProgressIndicator(
                    value: 40,
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        ApiService.instance!.deleteUser();
                      },
                      child: Text("Delete account")),
                  const Spacer(
                    flex: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        ApiService.instance!.signOut();
                      },
                      child: Text("sign out account")),
                  const Spacer(
                    flex: 10,
                  )
                ],
              ),
            ),
          );
        } else if (algo.finished == true) {
          Timer(Duration(seconds: 1), () async {
            Navigator.pop(context);
          });
        }

        return Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
