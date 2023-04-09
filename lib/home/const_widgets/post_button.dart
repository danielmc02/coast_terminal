import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../api_service.dart';
import '../../constants/boxes.dart';

class PostButton extends StatefulWidget {
  const PostButton({super.key});

  @override
  State<PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Color.fromARGB(255, 254, 44, 117)),
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 254, 44, 117)),
              overlayColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 255, 34, 111))),
          onPressed: () {
            if (Boxes.getuser().get('mainUser')!.hasPostedMessage == true) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                          "You can only post one message. If you would like to post a new message, please sign out and sign in again. Please note that signing out will delete all your progress, including your current message and all previously viewed messages."),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
                            child:
                                const Text("Okay, I understand"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              ApiService.instance!.pageController
                  .nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear)
                  .then((value) {
                setState(() {
                  ApiService.instance!.ref = false;
                  Timer(Duration(seconds: 1), () {
                    ApiService.instance!.ref = true;
                  });
                });
              });
            }
          },
          child: Text(
            "Post",
            style: Theme.of(context).textTheme.labelLarge,
          )),
    );
  }
}
