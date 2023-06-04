import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:coast_terminal/home/rdhome.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late int randomNumber;
  @override
  void initState() {
    randomNumber = Random().nextInt(facts.length);
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween<double>(begin: null, end: null).animate(_animationController);
  }

  List<String> facts = [
    "The human brain weighs about 3 pounds (1.4 kilograms).",
    "The average person has about 70,000 thoughts per day.",
    "Honey never spoils. Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still perfectly edible.",
    "The Great Wall of China is not visible from space with the naked eye, contrary to popular belief. It's challenging to see even from low Earth orbit.",
    "The world's oldest known university is the University of Al Quaraouiyine in Morocco, founded in 859 AD.",
    "The concept of the Internet was developed in the 1960s as a means of communication that could withstand a nuclear war.",
    "Antarctica is the world's largest desert. Despite its icy reputation, it receives very little precipitation.",
    "The shortest war in history lasted just 38 to 45 minutes. It occurred between Britain and Zanzibar on August 27, 1896.",
    "The average person will spend around 6 months of their life waiting at red traffic lights.",
    "Mount Everest, the highest peak in the world, continues to grow at a rate of about 0.16 inches (4 millimeters) per year.",
    "The world's largest volcano is Mauna Loa in Hawaii. It stands about 13,678 feet (4,169 meters) above sea level.",
    "The Eiffel Tower in Paris grows taller in the summer due to the expansion of the iron from the heat.",
    "The world's largest known prime number has over 24 million digits.",
    "The average adult human body contains enough bones to make up an entire human skeleton.",
    "The average person will spend about 25 years of their life asleep.",
    "There are more possible iterations of a game of chess than there are atoms in the known universe.",
    "The shortest commercial flight in the world is between two Scottish islands, Westray and Papa Westray, and lasts only 1.7 miles (2.7 kilometers) and about 47 seconds.",
    "The world's largest underground cave chamber is the Sarawak Chamber in Malaysia, which is large enough to fit 40 Boeing 747s.",
    "The oldest known living tree, named Methuselah, is over 4,800 years old and can be found in the White Mountains of California.",
    "The human body contains enough carbon to fill about 9,000 pencils.",
    "The Hawaiian alphabet has only 12 letters: A, E, I, O, U, H, K, L, M, N, P, and W.",
    "The national animal of Scotland is the unicorn.",
    "The first recorded use of the hashtag symbol (#) to categorize topics on social media was on Twitter in 2007.",
    "The average person will eat about 35 tons of food in their lifetime.",
    "Leonardo da Vinci could write with one hand and draw with the other simultaneously.",
    "The shortest distance between Russia and the United States is about 2.4 miles (3.8 kilometers) across the Bering Strait.",
    "The world's largest pyramid is not in Egypt but in Cholula, Mexico. It is known as the Great Pyramid of Cholula.",
    "The average person produces about 25,000 quarts (23,700 liters) of saliva in a lifetime.",
    "There is a species of jellyfish known as the immortal jellyfish that can revert back to its juvenile form after reaching maturity."
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(this.context),
      builder: (context, child) => Consumer<HomeProvider>(
          builder: (context, algo, child) => algo.metReq == false
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color.fromARGB(0, 210, 222, 255),
                    shadowColor: Colors.transparent,
                    foregroundColor: const Color.fromARGB(0, 162, 34, 34),
                    surfaceTintColor: Colors.transparent,
                  ),
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              totalRepeatCount: 3,
                              // pause: Duration(seconds: 0),
                              animatedTexts: <AnimatedText>[
                                FadeAnimatedText(facts[randomNumber],
                                    duration: const Duration(seconds: 300),
                                    fadeInEnd: .005,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.center)
                              ]),
                        ),
                        Container(
                          //color: Color.fromARGB(159, 158, 158, 158),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) =>
                                      CircularProgressIndicator(
                                    strokeWidth: 15,
                                    color: Colors.black,
                                    value: algo.progress,
                                    backgroundColor: Colors.grey,
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                        Colors.green),
                                  ),
                                ),
                                Center(
                                    child: Text(
                                        "${(algo.progress * 100).toStringAsFixed(algo.progress % 1 == 0 ? 0 : 1).replaceAll(RegExp(r'\.0+$'), '')}%"))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          algo.status,
                          style: const TextStyle(
                              color: Color.fromARGB(110, 0, 0, 0)),
                        )
                      ],
                    ),
                  ),
                )
              : const RDHOME2() //Home()
          ),
    );
  }
}
