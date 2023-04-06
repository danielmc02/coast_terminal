import 'package:coast_terminal/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Heart extends StatelessWidget {
  const Heart({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) => Consumer<HomeProvider>(builder: (context, algo, child) => FutureBuilder(
                                future: algo.calculate(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData == false) {
                                    return Text("No data");
                                  } else if (snapshot.hasData == true) {
                                    print(snapshot.data);
                                    return Column(
                                      children: [
                                        Text("has data"),
                                        Row(children: [
                                          
                                        ],)
                                      ],
                                    );
                                  }
                                  return Text("error");
                                }),),
    );
  }
}
