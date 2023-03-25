import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../api_service.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
                  create: (context) => HomeProvider(),
                  builder: (context, child) => Consumer<HomeProvider>(
                        builder: (context, value, child) => Scaffold(
                          body: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("intro"),
                              TextButton(
                                  onPressed: () {
                                    ApiService.instance!.signOut();
                                  },
                                  child: const Text("sign out"))
                            ],
                          ),
                        ),
                      ));
  }
}