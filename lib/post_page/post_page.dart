import 'package:coast_terminal/post_page/post_page_provider/post_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: Consumer<PostProvider>(
        builder: (context, algo, child) => Scaffold(
          appBar: AppBar(
            title: Text("post"),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
              /* Row(
                  children: [
                    Text("Icon"),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                content: Text(
                                    "This icon is shown when someone recieves your message. Use it to express how you are feeling in order to show context")),
                          );
                        },
                        icon: Icon(Icons.question_mark))
                  ],
                ),*/
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,//algo.badges.length,
                    itemBuilder: (context, index) {
                      Container(color: Colors.red,width: 200,height: 200,);
                    },
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
