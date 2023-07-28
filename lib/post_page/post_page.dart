import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/home/const_widgets/post_button.dart';
import 'package:coast_terminal/post_page/post_page_provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: Consumer<PostProvider>(
        builder: (context, algo, child) => Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PostButton(onPressed: () async {

                    if (algo.fromKey.currentState!.validate()) {
                            ApiService.instance!.currentMessageSucessresult =
                                await algo.postMessage(
                                    algo.currentValue.toInt(),
                                    algo.titleController.text.toString(),
                                    algo.messageController.text.toString());
                            print(
                                "status report: value is ${ApiService.instance!.currentMessageSucessresult}");
                            ApiService.instance!.currentMessageSucessresult
                                ? ApiService.instance!.pageController
                                    .animateToPage(0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.linear)
                                : showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                              "There was an error in uploading your message. Try again later or update the app if possible."),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            side: const BorderSide(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.white),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all(Colors.grey)),
                                                child: const Text(
                                                    "Okay, I understand"),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          }
                }),
              ],
            ),
          ),
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
                  child: ClipOval(
                      child:
                          SizedBox(width: 50, height: 50, child: algo.chosen)));
            }),
            drawer: Drawer(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              backgroundColor: const Color.fromARGB(255, 12, 12, 12),
              child: DrawerBody(),
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              shadowColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  ApiService.instance!.pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
              ),
              title: const Text(
                "Post",
                style: TextStyle(
                    fontFamily: "OpanSans",
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
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
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    print("being disposed");
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, algo, child) =>  Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SizedBox(
            //    color: Colors.green,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Form(
                  key: algo.fromKey,
                  // autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    //   color: Color.fromARGB(192, 194, 13, 13),
                    child: TextFormField(
                      validator: (val) {
                        String value = val!.toLowerCase();
                        if (value.length < 10) {
                          return "Title is to short";
                        } else if (value.contains("fuck") ||
                            value.contains("shit") ||
                            value.contains("ass") ||
                            value.contains("bitch") ||
                            value.contains("cunt") ||
                            value.contains("dick") ||
                            value.contains("pussy") ||
                            value.contains("cock") ||
                            value.contains("bastard") ||
                            value.contains("whore") ||
                            value.contains("slut") ||
                            value.contains("motherfucker") ||
                            value.contains("asshole") ||
                            value.contains("douchebag") ||
                            value.contains("wanker") ||
                            value.contains("piss") ||
                            value.contains("fag") ||
                            value.contains("twat") ||
                            value.contains("bollocks") ||
                            value.contains("arse") ||
                            value.contains("cocksucker") ||
                            value.contains("blowjob") ||
                            value.contains("tits") ||
                            value.contains("nigger") ||
                            value.contains("chink") ||
                            value.contains("spic") ||
                            value.contains("retard") ||
                            value.contains("crap") ||
                            value.contains("dumbass") ||
                            value.contains("jackass")) {
                          return "Can't use this title at this time";
                        }
                        return null;
                      },
                      controller: algo.titleController,
                      inputFormatters: const [
                        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z_]'),)
                      ],
                      cursorColor: const Color.fromARGB(255, 183, 183, 183),
                      showCursor: true,
                      maxLength: 30,
                      style: const TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.black,
                          fontSize: 35),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
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
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  //   color: Color.fromARGB(168, 17, 54, 187),
                  child: TextFormField(
                    maxLength: 400,
                    validator: (val) {
                      String value = val!.toLowerCase();
                      if (value.length < 200) {
                        return "Message is to short";
                      } else if (value.contains("fuck") ||
                          value.contains("shit") ||
                          value.contains("ass") ||
                          value.contains("bitch") ||
                          value.contains("cunt") ||
                          value.contains("dick") ||
                          value.contains("pussy") ||
                          value.contains("cock") ||
                          value.contains("bastard") ||
                          value.contains("whore") ||
                          value.contains("slut") ||
                          value.contains("motherfucker") ||
                          value.contains("asshole") ||
                          value.contains("douchebag") ||
                          value.contains("wanker") ||
                          value.contains("piss") ||
                          value.contains("fag") ||
                          value.contains("twat") ||
                          value.contains("bollocks") ||
                          value.contains("arse") ||
                          value.contains("cocksucker") ||
                          value.contains("blowjob") ||
                          value.contains("tits") ||
                          value.contains("nigger") ||
                          value.contains("chink") ||
                          value.contains("spic") ||
                          value.contains("retard") ||
                          value.contains("crap") ||
                          value.contains("dumbass") ||
                          value.contains("jackass")) {
                        return "Can't process this message at this time";
                      }
                      return null;
                    },
                    controller: algo.messageController,
                    showCursor: true,
                    cursorColor: const Color.fromARGB(255, 183, 183, 183),
                    //  maxLength: 500,
                    minLines: 15,
                    maxLines: 15,
                    style: const TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.black,
                        fontSize: 20),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        //  borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
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
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  //color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                          style: const TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 21),
                          "${algo.currentValue.toInt()} ${algo.currentValue == 1 ? "Person" : "People"} will see your message"),
                      Container(
                          //color:Colors.red
                          child: Slider(
                        activeColor: Colors.green,
                        inactiveColor: Colors.red,
                        thumbColor: Colors.black45,
                        overlayColor: MaterialStateProperty.all(Colors.white24),
                        value: algo.currentValue,
                        min: 1,
                        max: 10,
                        divisions: 9, // Divisions should be max - min - 1
                        onChanged: (double value) {
                          setState(() {
                            algo.currentValue = value
                                .roundToDouble(); // Round to nearest integer
                          });
                        },
                        // label: _currentValue.toInt().toString(),
                      )),
                      const SizedBox(
                        height: 8,
                      ),
                    /*  Consumer<PostProvider>(
                        builder: (context, algo, child) => PostButton(
                          onPressed: () async {
                          
                          },
                        ),
                      )*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget DrawerBody() {
  return Consumer<PostProvider>(
    builder: (context, algo, child) => Padding(
      padding: const EdgeInsets.only(top: 50, left: 20),
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Icons",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.white,
                            fontSize: 50),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    //  color: Colors.red,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 24, left: 8, top: 0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        physics: const ClampingScrollPhysics(),
                        itemExtent: 80,
                        shrinkWrap: true,
                        itemCount: algo.badges.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                algo.updateBadges(index);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ChoiceChip(
                                      elevation: algo.badges[algo.badges.keys
                                              .elementAt(index)]!['selected']
                                          ? 5
                                          : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      selectedColor: Colors.white,
                                      onSelected: (value) {
                                        algo.updateBadges(index);

                                        print(
                                            "${algo.badges.keys.elementAt(index)} was pressed $index ${algo.badges[algo.badges.keys.elementAt(index)]!['selected']} ");
                                      },
                                      label: CircleAvatar(
                                        child: ClipOval(
                                          child: algo.badges[algo.badges.keys
                                              .elementAt(index)]!['icon'],
                                        ),
                                      ),
                                      selected: algo.badges[algo.badges.keys
                                          .elementAt(index)]!['selected']),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        algo.badges.keys.elementAt(index),
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            color: algo.badges[algo.badges.keys
                                                    .elementAt(
                                                        index)]!['selected']
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    61, 240, 240, 240),
                                            fontSize: 25)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    ),
  );
}

Widget messageBox() {
  return const SizedBox(
    width: 400,
    //height: 300,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(),
        )
      ],
    ),
  );
}
