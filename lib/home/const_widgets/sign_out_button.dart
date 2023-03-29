import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../api_service.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return         TextButton(
                              onPressed: () {
                                ApiService.instance!.signOut();
                              },
                              child: const Text("sign out"));
  }
}