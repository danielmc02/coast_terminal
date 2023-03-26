import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/post_page/post_page_provider/post_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late TextEditingController titleController;
  late TextEditingController messageController;
  String title = "";
  String message = "";
  @override
  void initState() {
    titleController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    print("being disposed");
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: Consumer<PostProvider>(
        builder: (context, algo, child) => Scaffold(
          // backgroundColor: Color.fromARGB(255, 241, 241, 241),
          appBar: AppBar(
            title: const Text("Post"),
          ),
          body: Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  Text(
                    "Icon",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              content: Text(
                                  "This icon is shown when someone recieves your message. Use it to express how you are feeling in order to show context")),
                        );
                      },
                      icon: const Icon(Icons.question_mark))
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 100,
                width: 700,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: algo.badges.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          elevation: algo.badges[algo.badges.keys
                                  .elementAt(index)]!['selected']
                              ? 10
                              : 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          selectedColor: Colors.white,
                          onSelected: (value) {
                            algo.updateBadges(index);

                            print(
                                "${algo.badges.keys.elementAt(index)} was pressed $index ${algo.badges[algo.badges.keys.elementAt(index)]!['selected']} ");
                          },
                          label: CircleAvatar(
                            child: ClipOval(
                              child: algo.badges[
                                  algo.badges.keys.elementAt(index)]!['icon'],
                            ),
                          ),
                          selected: algo.badges[
                              algo.badges.keys.elementAt(index)]!['selected']),
                    );
                  },
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Text("Title"),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              content: Text(
                                  "This is shown as a heading above your message")),
                        );
                      },
                      icon: const Icon(Icons.question_mark)),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    onChanged: (value) => title = value,
                    controller: titleController,
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
              const Spacer(),
              Row(
                children: [
                  const Text("Message"),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              content: Text(
                                  "Enter your message for a random person to see")),
                        );
                      },
                      icon: const Icon(Icons.question_mark)),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 6,
                  color: const Color.fromARGB(255, 234, 235, 240),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => message = value,
                      controller: messageController,
                      maxLines: 10,
                      maxLength: 500,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(2)),
                          hintText: "Whats going on?"),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 20,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 254, 44, 117)),
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 254, 44, 117)),
                        overlayColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 34, 111))),
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        barrierColor: const Color.fromARGB(222, 0, 0, 0),
                        context: context,
                        builder: (context) {
                          return Stack(
                            children: [
                              Column(
                                // mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Spacer(),
                                  AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        FadeAnimatedText(
                                          "Swype down to cancel",
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        )
                                      ]),
                                  const Spacer(),
                                  Material(
                                    child: ListTile(
                                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
                                      leading: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          minRadius: 80,
                                          child: algo.chosen,
                                        ),
                                      ),
                                      title: Text(title),
                                      subtitle: Text(message),
                                    ),
                                  ),
                                  const Spacer(),
                                  AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        FadeAnimatedText(
                                          "Swype up to post",
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        )
                                      ]),
                                  const Spacer()
                                ],
                              ),
                              Container(
                                // color: Color.fromARGB(118, 255, 193, 7),
                                child: GestureDetector(
                                  onVerticalDragEnd: (details) {
                                    if (details.primaryVelocity! > 0) {
                                      print('User swiped down');
                                      Navigator.pop(context);
                                    } else if (details.primaryVelocity! < 0) {
                                      print('User swiped up');
                                      Navigator.pop(context);
                                      ApiService.instance!.pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
                                    }
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Post",
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
              ),
              const Spacer(flex: 10)
            ],
          ),
        ),
      ),
    );
  }
}

Widget messageBox() {
  return SizedBox(
    width: 400,
    height: 300,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextField(
          decoration: InputDecoration(),
        )
      ],
    ),
  );
}

Widget badgeTemplate(String title, dynamic icon) {
  return Material(
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              minRadius: 80,
              child: icon,
            ),
          ),
          Text(title)
        ],
      ),
    ),
  );
}
