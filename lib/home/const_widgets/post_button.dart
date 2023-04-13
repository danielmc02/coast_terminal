import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../api_service.dart';
import '../../constants/boxes.dart';






class PostButton extends StatelessWidget {
   PostButton({super.key, required this.onPressed});
late VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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
          onPressed:onPressed,
          child: Text(
            "Post",
            style: Theme.of(context).textTheme.labelLarge,
          )),
    );
  }
}