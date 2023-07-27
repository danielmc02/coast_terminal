import 'dart:io';

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
          body: Container(
            color: Colors.white, width: MediaQuery.of(context).size.width,
            //color: Colors.red
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (val) {
                    String value = val!.toLowerCase();
                    if (value.length < 10) {
                      return "Title is to short";
                    }
                    return null;
                  },
                  // controller: titleController,
                  inputFormatters: const [
                    // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z_]'),)
                  ],
                  cursorColor: const Color.fromARGB(255, 183, 183, 183),
                  showCursor: true,
                  maxLength: 30,
                  style: const TextStyle(
                      fontFamily: "Roboto", color: Colors.black, fontSize: 35),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero,
                    ),
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color:
                          Colors.grey.withOpacity(0.5), // set the hint text opacity
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) {
                      String value = val!.toLowerCase();
                      if (value.length < 200) {
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
                        fontFamily: "Roboto", color: Colors.black, fontSize: 20),
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
             onTap: () async{print("TAPPED");
                   await algo.processPictureUpload();
                    },
            child: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: algo.image != null ? FileImage(algo.image!) : null,
              minRadius: 65,
              //radius: 70,
              maxRadius: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: algo.image == null ? Column(
                  children: [
                    Icon(Icons.photo,size: 50,),
                                              Text("Post a picture from your ${Platform.isAndroid ? "gallery" : "photos"}",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSans",color: Colors.white,fontWeight: FontWeight.bold),)
              
                  ],
                ) : null,
              ),
            ),
          ),
                         SizedBox(width: 24,),  GestureDetector(
             onTap: () async{print("TAPPED");
                  showDialog(context: context, builder: (context) {
                    
                return   AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            SizedBox(
                                                //   color: Colors.red,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)))),
                                                    onPressed: () async {
                                                      Navigator.pop(context);

                                                   
                                                    },
                                                    child:
                                                        const Text("Done")))
                                          ],
                                          //alignment: Alignment.center,

                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "Make sure the url is valid",
                                                textAlign: TextAlign.center,
                                              ),
                                              URLValidationTextField()
                                            ],
                                          ),

                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: const Text(
                                            "Post a link",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                     
                  },);
                    },
            child: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: algo.image != null ? FileImage(algo.image!) : null,
              minRadius: 65,
              //radius: 70,
              maxRadius: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: algo.image == null ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.link,size: 50,),
                                              Text("Post a link",textAlign: TextAlign.center,style: TextStyle(fontFamily: "OpenSans",color: Colors.white,fontWeight: FontWeight.bold),)
              
                  ],
                ) : null,
              ),
            ),
          ),
                
                          SizedBox(height: 8,)
        ],
       )
                   
               
        , PostButton(onPressed: (){

                }),
      
           
              ],
            ),
      
          ),
        ),
      ),
    );
  }
}



class URLValidationTextField extends StatefulWidget {
  @override
  _URLValidationTextFieldState createState() => _URLValidationTextFieldState();
}

class _URLValidationTextFieldState extends State<URLValidationTextField> {
  TextEditingController _urlController = TextEditingController();
  bool _isValidUrl = true;

  // Regular expression to check if the input is a valid URL
  RegExp _urlRegex = RegExp(
    r'^(https?://)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$',
    caseSensitive: false,
    multiLine: false,
  );

  // Function to validate the URL
  bool _validateUrl(String value) {
    return _urlRegex.hasMatch(value);
  }

  // Function to handle the onChanged event of the TextField
  void _onTextChanged(String value) {
    setState(() {
      _isValidUrl = _validateUrl(value);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _urlController,
          onChanged: _onTextChanged,
          decoration: InputDecoration(
            labelText: 'Enter a URL',
            errorText: !_isValidUrl ? 'Invalid URL' : null,
          ),
        ),
       
      ],
    );
  }
}