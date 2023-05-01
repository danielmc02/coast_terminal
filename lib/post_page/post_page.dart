import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/home/const_widgets/post_button.dart';
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
                  child: ClipOval(
                      child: Container(
                          width: 50, height: 50, child: algo.chosen)));
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
   late TextEditingController titleController;
  late TextEditingController messageController;

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
  double _currentValue = 1;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 0),
        child: SizedBox(height: MediaQuery.of(context).size.height,
          child: Container(
            
        //    color: Colors.green,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                   //   color: Color.fromARGB(192, 194, 13, 13),
                      child: TextField(
                        controller: titleController,
                        inputFormatters: [
                          // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z_]'),)
                        ],
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
                  height: 8,
                ),
                Flexible(
                    flex: 3,
                    child: Container(
                    //  color: Color.fromARGB(168, 17, 54, 187),
                      child: TextField(
                        controller: messageController,
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
                    SizedBox(height: 48,),
                Flexible(
                    flex: 1,
                 //   child: Container(color: Color.fromARGB(153, 255, 193, 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(style:TextStyle(
                                      fontFamily: "Roboto", color: Colors.black, fontSize: 21),
                              "${_currentValue.toInt()} ${_currentValue == 1 ? "Person" : "People"} will see your message"),
                          Container(
                              //color:Colors.red
                              child: Slider(
                            activeColor: Colors.green,
                            inactiveColor: Colors.red,
                            thumbColor: Colors.black45,
                            overlayColor:
                                MaterialStateProperty.all(Colors.white24),
                            value: _currentValue,
                            min: 1,
                            max: 10,
                            divisions: 9, // Divisions should be max - min - 1
                            onChanged: (double value) {
                              setState(() {
                                _currentValue = value
                                    .roundToDouble(); // Round to nearest integer
                              });
                            },
                            // label: _currentValue.toInt().toString(),
                          )),SizedBox(height: 8,),
                          Consumer<PostProvider>(
                            builder: (context, algo, child) =>  PostButton(onPressed: () async{
                            
                            ApiService.instance!.currentMessageSucessresult = await algo.postMessage(_currentValue.toInt(), titleController.text.toString(), messageController.text.toString());
                            print("status report: value is ${ApiService.instance!.currentMessageSucessresult}");
                            ApiService.instance!.currentMessageSucessresult ? ApiService.instance!.pageController.animateToPage(0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear) : showDialog(context: context, builder: (context)=>AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                            "There was an error in uploading your message. Try again."),
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
                  ),);
                            },),
                          )
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
    builder: (context, algo, child) => 
       Padding(
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
                          style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 50),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      //color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 24, left: 8, top: 0),
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          physics: ClampingScrollPhysics(),
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
                                child: Row( mainAxisSize: MainAxisSize.max,
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
                                              color: algo.badges[algo
                                                      .badges.keys
                                                      .elementAt(
                                                          index)]!['selected']
                                                  ? Colors.black
                                                  : Color.fromARGB(62, 0, 0, 0),
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
