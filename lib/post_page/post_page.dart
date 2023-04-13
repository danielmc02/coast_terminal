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
  double sliderValue = 1;
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
bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: Consumer<PostProvider>(
          builder: (context, algo, child) => Scaffold(
                    onDrawerChanged: (isOpened) {
              setState(() {
                              isOpen = !isOpen;

              });
            },
              floatingActionButtonLocation: isOpen
                  ? FloatingActionButtonLocation.endDocked
                  : FloatingActionButtonLocation.startDocked,
              floatingActionButton: Builder(builder: (context) {
                return FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                     
                      Scaffold.of(context).openDrawer();
                    },
                    child: ClipOval(child: Container(width: 50, height: 50, child: algo.chosen)));
              }),
              drawer: Drawer(
                child: DrawerBody(),
              ),
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 56, 62, 78),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    ApiService.instance!.pageController.animateToPage(0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear);
                  },
                ),
                title: const Text("Post"),
              ),
              body: PostBody()),
        
      ),
    );
  }
}

class PostBody extends StatefulWidget {
  const PostBody({super.key});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      color: Color.fromARGB(0, 215, 107, 107),
                      child: TextField(
                        cursorColor: Color.fromARGB(255, 183, 183, 183),
                        showCursor: true,
                        maxLength: 30,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.black,
                            fontSize: 35),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.zero,
                          ),
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            color: Colors.grey
                                .withOpacity(0.5), // set the hint text opacity
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                      //color: Color.fromARGB(168, 139, 215, 107),
                      child: TextField(
                        showCursor: true,
                        cursorColor: Color.fromARGB(255, 183, 183, 183),
                        maxLength: 500,
                        minLines: 22,
                        maxLines: 22,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.black,
                            fontSize: 20),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            //  borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            //  borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Message',
                          hintStyle: TextStyle(
                            color: Colors.grey
                                .withOpacity(0.5), // set the hint text opacity
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget DrawerBody() {
  return Consumer<PostProvider>(builder: (context, algo, child) => Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(top: 50, left: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Icons",
                      style: TextStyle(fontFamily: "Roboto", color: Colors.black,fontSize: 50),
                    ),
                    
                  ],
                  
                ),
              ),
              Flexible(
                child: Container(
                  //color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 24,left: 8,top:0),
                    child: ListView.builder(padding: EdgeInsets.only(top: 0),
                    physics: ClampingScrollPhysics(),itemExtent: 80,shrinkWrap: true,itemCount:algo.badges.length ,itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                algo.updateBadges(index);
                              },
                              child: Row(
                                children: [
                                 ChoiceChip(
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
                                      selected: algo.badges[algo.badges.keys
                                          .elementAt(index)]!['selected']),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(algo.badges.keys.elementAt(index),style:TextStyle(
                                              fontFamily: "Roboto", color: algo.badges[algo.badges.keys
                                              .elementAt(index)]!['selected']?Colors.black:Color.fromARGB(62, 0, 0, 0), fontSize: 25)),
                                          )
                                ],
                              ),
                            ),
                          );
                        },),
                  ),
                ),
              )
            ],
          ),
        )),
      );
    }),
  );
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

/*
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
*/

/*
class DUD extends StatelessWidget {

  const DUD({super.key});

  @override
  Widget build(BuildContext context) {
    return           Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //const Spacer(),
                  Expanded(
                    child: Row(
                      children: [ListView.builder(itemCount:3 ,itemBuilder: (context, index) {
                    return Container(width: 20,height: 50,color: Colors.red,);
                  },)
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
                  ),
                  //const Spacer(),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
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
                                selected: algo.badges[algo.badges.keys
                                    .elementAt(index)]!['selected']),
                          );
                        },
                      ),
                    ),
                  ),
                 // const Spacer(),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[1-9]|1[0-9]|20')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 1 || number > 20) {
                          return 'Please enter a number between 1 and 20';
                        }
                        return null;
                      },
                    ),
                  ),
                 // const Spacer(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${sliderValue.toInt()}/20"),
                          Icon(Icons.remove_red_eye)
                        ],
                      ),
                    ),
                  ),
                  //const Spacer(),
                        
                  /*
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
                  */
                 // const Spacer(),
                  Expanded(
                    child: Padding(
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
                            hintText: "Title",
                            border: UnderlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                          )),
                    ),
                  ),
                  //const Spacer(),
                  Expanded(
                    child: Row(
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
                  ),
                  //const Spacer(),
                  Expanded(
                    child: Padding(
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
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(2)),
                                hintText: "Whats going on?"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //const Spacer( flex: 20,  ),
                  Expanded(
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
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
                                            //print("${titleController.text} vs ${messageController.text}");
                                            algo.postMessage(
                                                sliderValue,
                                                titleController.text,
                                                messageController.text);
                                            Navigator.pop(context);
                                            ApiService.instance!.pageController
                                                .animateToPage(0,
                                                    duration:
                                                        Duration(milliseconds: 500),
                                                    curve: Curves.linear);
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
                  ),
                  //const Spacer(flex: 10)
                ],
              ),
            ),
          ),
  }
}
*/