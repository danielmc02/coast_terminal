import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coast_terminal/home/const_widgets/post_button.dart';
import 'package:coast_terminal/home/private_page/provider/private_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivatePostPage extends StatefulWidget {
  const PrivatePostPage({super.key});

  @override
  State<PrivatePostPage> createState() => _PrivatePostPageState();
}

class _PrivatePostPageState extends State<PrivatePostPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrivPostProvider(),
      builder: (context, child) => Consumer<PrivPostProvider>(
        builder: (context, algo, child) => Scaffold(
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PostButton(onPressed: () async {
                    if (algo.fromKey.currentState!.validate()) {
                      await algo.postVipMessage();
                    } else {
                      print("not valid");
                    }
                  }),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            // toolbarHeight: 80,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "VIP Post",
              style: TextStyle(
                  fontFamily: "OpanSans",
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: algo.fromKey,
              child: Container(
                color: Colors.white, width: MediaQuery.of(context).size.width,
                //color: Colors.red
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) async{
                        await algo.updateTitleStatus();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: algo.titleController,
          
                      validator: (val) {
                        String value = val!.toLowerCase();
                        if (value.length < 10) {
                      
                        //    algo.updateTitleStatus(false);
                        
                          return "Title is to short";
                        } else {
                   
                        //    algo.updateTitleStatus(true);
             
                          return null;
                        }
                      },
                      // controller: titleController,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        
                        controller: algo.messageController,
                        onChanged: (value) async{
                          await algo.updateMessageStatus();
                        },
                        validator: (val) {
                          String value = val!.toLowerCase();
                          if (value.length < 50) {
                            return "Message is to short";
                          }
                          return null;
                        },
                        //   controller: messageController,
                        showCursor: true,
                        cursorColor: const Color.fromARGB(255, 183, 183, 183),
                        maxLength: 300,
                        minLines: 4,
                        maxLines: 4,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print("TAPPED");
                       //     await algo.processPictureUpload();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: algo.image != null
                                ? FileImage(algo.image!)
                                : null,
                            minRadius: 65,
                            //radius: 70,
                            maxRadius: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: algo.image == null
                                  ? Column(
                                      children: [
                                        const Icon(
                                          Icons.photo,
                                          size: 50,
                                        ),
                                        Text(
                                          "Post a picture from your ${Platform.isAndroid ? "gallery" : "photos"}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: "OpenSans",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        GestureDetector(
                          onTap: () async {
                            print("TAPPED");
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    SizedBox(
                                        //   color: Colors.red,
                                        width: MediaQuery.of(context).size.width,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.blueAccent),
                                                foregroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.white),
                                                shape: MaterialStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)))),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Done")))
                                  ],
                                  //alignment: Alignment.center,
          
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Make sure the url is valid",
                                        textAlign: TextAlign.center,
                                      ),
                                      TextField(
                                        controller: algo.urlController,
                                        onChanged: (value) {
                                          setState(() {
                                            algo.onTextChanged(value);
                                            print(algo.isValidUrl);
                                          });
                                        }, // _onTextChanged,
                                        decoration: InputDecoration(
                                          labelText: 'Enter a URL',
                                          errorText: !algo.isValidUrl
                                              ? 'Invalid URL'
                                              : "valid",
                                        ),
                                      ),
                                    ],
                                  ),
          
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: const Text(
                                    "Post a link",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.black,
          
                            minRadius: 65,
                            //radius: 70,
                            maxRadius: 70,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.link,
                                      size: 50,
                                    ),
                                    Text(
                                      "Post a link",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "OpenSans",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                    /*    Row(mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black,
                                      fontSize: 21),
                                  "${algo.sliderValue.toInt()} ${algo.sliderValue == 1 ? "Person" : "People"} will see your message"),
                   ],
                 ),
                  Slider(
                            activeColor: Colors.green,
                            inactiveColor: Colors.red,
                            thumbColor: Colors.black45,
                            overlayColor: MaterialStateProperty.all(Colors.white24),
                            value: algo.sliderValue,
                            min: 1,
                            max: 50,
                            divisions: 49, // Divisions should be max - min - 1
                            onChanged: (double value) {
                              setState(() {
                              algo.sliderValue = value.roundToDouble();
                               // algo.currentValue = value
                                    //.roundToDouble(); // Round to nearest integer
                              });
                            },
                            // label: _currentValue.toInt().toString(),
                          )*/
          
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Title: ",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              algo.hasTitle == false
                                  ? AnimatedTextKit(
                                      repeatForever: true,
                                      isRepeatingAnimation: true,
                                      animatedTexts: <FadeAnimatedText>[
                                          FadeAnimatedText("Needs a title")
                                        ])
                                  : const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Message: ",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ), algo.hasMessage == false ?
                              AnimatedTextKit(
                                  repeatForever: true,
                                  isRepeatingAnimation: true,
                                  animatedTexts: <FadeAnimatedText>[
                                    FadeAnimatedText("Needs a message")
                                  ]) : const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                              algo.hasPicture ?   "Picture: +10" : "Picture: ",
                                style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                algo.urlValue != null ?   "Link: +10" : "Link: ",
                                style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Cost: ${algo.costValue} ",
                                style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              const Icon(
                                Icons.generating_tokens,
                                color: Color.fromARGB(255, 177, 159, 0),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
