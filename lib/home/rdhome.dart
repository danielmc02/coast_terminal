import 'package:flutter/material.dart';

import '../api_service.dart';
import '../constants/boxes.dart';
import 'const_widgets/post_button.dart';

class RDHOME extends StatefulWidget {
  const RDHOME({super.key});

  @override
  State<RDHOME> createState() => _RDHOMEState();
}

class _RDHOMEState extends State<RDHOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container(width: MediaQuery.of(context).size.width,color: Colors.red,
          child: SingleChildScrollView(
            child: SizedBox(width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                       FutureBuilder(
                          future: ApiService.instance!.fetchMessageIfExists(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Text("Loading"),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                           //   print("AAAAAA${snapshot.data}");
                              if (snapshot.data == null) {
                                return Expanded(
                                  flex: 80,
                                  child: Container(
                                    //   color: Colors.red,
                                    child: AlertDialog(
                                      title: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Empty"),
                                          Icon(
                                            Icons.warning_amber_outlined,
                                            color: Colors.redAccent,
                                          )
                                        ],
                                      )),
                                      content: Text(
                                          "This is awkward. There are currently no messages to show at this time."),
                                    ),
                                  ),
                                );
                              } else if (snapshot.data != null) {
                                return Expanded(
                                    flex: 80,
                                    child: Container(
                                      color: Colors.red,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              elevation: 20,
                                              color: Colors.transparent,
                                              child: Ink(
                                                height: 300,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            105, 0, 0, 0),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: Color.fromARGB(
                                                        119, 255, 255, 255)),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  splashColor: Colors.red,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        CircleAvatar(
                                                            backgroundColor: Colors
                                                                .transparent,
                                                            radius: 30,
                                                            foregroundImage: ApiService
                                                                .instance!
                                                                .iconReferences[Boxes
                                                                    .getMessage()
                                                                .get(
                                                                    'currentMessage')!
                                                                .iconIndex]),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: FittedBox(
                                                              child: Text(
                                                                Boxes.getMessage()
                                                                    .get(
                                                                        'currentMessage')!
                                                                    .title,
                                                                style: TextStyle(
                                                                    fontSize: 40),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Container(
                                                              //color:Colors.green,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Scrollbar(
                                                                thumbVisibility:
                                                                    false,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Text(
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18),
                                                                      Boxes.getMessage()
                                                                          .get(
                                                                              'currentMessage')!
                                                                          .message),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                            child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(Icons
                                                                .remove_red_eye_outlined),
                                                            Text(
                                                                "${Boxes.getMessage().get('currentMessage')!.currentViews}/${Boxes.getMessage().get('currentMessage')!.views}"),
                                                            Spacer(),
                                                            TextButton(
                                                                onPressed: () {},
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        color: Colors
                                                                            .green,
                                                                        Icons
                                                                            .thumb_up),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text('3')
                                                                  ],
                                                                )),
                                                            TextButton(
                                                                onPressed: () {},
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                        color: Colors
                                                                            .red,
                                                                        Icons
                                                                            .thumb_down),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text('3')
                                                                  ],
                                                                ))
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                         
                                        ],
                                      ),
                                    ));
                              }
                              ;
                            }
                            return Text("error");
                          },
                        )
                  ],
              ),
            ),
          ),)),
          Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.white54,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Modal BottomSheet'),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                ),
                                child: const Text('Delete Account'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ApiService.instance!.signOut();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.settings_outlined),
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    return value!.length < 5
                        ? "Should be greater than 5"
                        : null;
                  },
                  //   controller: _chatController,
                  maxLines: 1,
                  // maxLength: 50,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: .5,
                              color: Colors.black)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: .5,
                              color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: .5,
                              color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: .5,
                              color: Colors.black)),
                      filled: true,
                      suffixIcon: TextButton(
                        onPressed: () {
                          /*   if (_formKey.currentState!
                                                          .validate()) {
                                                        print("continue");
                                                      } else {
                                                        print(
                                                            "error, can't send chat");
                                                      }*/
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "rSend a chat",
                      fillColor: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        elevation: 0,
        padding: EdgeInsets.all(8),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PostButton(
              onPressed: () {
                // Your code here
              },
            ),
          ],
        ),
      ),
    );
  }
}
