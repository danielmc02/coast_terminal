import 'package:coast_terminal/post_page/post_page_provider/post_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          body: Column(
            children: [
              Spacer(),
              Row(
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
              ),
              Spacer(),
              SizedBox(
                height: 100,
                child: Container(
                  color: Colors.red,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                      badgeTemplate(),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text("Title"),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              content: Text(
                                  "This is shown as a heading above your message")),
                        );
                      },
                      icon: Icon(Icons.question_mark)),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    maxLength: 50,
                    inputFormatters: [
                      //FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z_]'))
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue[50],
                      hintText: "Enter your name",
                      border: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)),
                    )),
              ),
              Spacer(),
              Row(
                children: [
                  Text("Message"),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              content: Text(
                                  "Enter your message for a random person to see")),
                        );
                      },
                      icon: Icon(Icons.question_mark)),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 5,
                  maxLength: 500,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Add Message"),
                ),
              ),
              Spacer(
                flex: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget badgeTemplate() {
  return Material(
    child: Padding(
      padding: EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              minRadius: 50,
              foregroundImage: AssetImage('assets/face_icons/happy.png'),
            ),
          ),
          Text("Happy")
        ],
      ),
    ),
  );
}
