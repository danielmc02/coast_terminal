
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rive/rive.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children:  [
           const Spacer(flex: 10,),
            //const SizedBox(width:300,height:300,child: RiveAnimation.asset(animations:,"./assets/rive_assets/movingplane.riv",fit: BoxFit.contain,)),
            const Spacer(flex: 50,),
            AnimatedTextKit(animatedTexts: [FadeAnimatedText("Loading anonymous token")]),
            const Spacer(flex: 20,),
            const LinearProgressIndicator(value: 40,),
           const Spacer(flex: 10,)

          ],
      
        ),
      ),
    );
  }
}