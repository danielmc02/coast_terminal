import 'package:coast_terminal/home/const_widgets/post_button.dart';
import 'package:coast_terminal/home/private_page/provider/private_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivatePostPage extends StatelessWidget {
  const PrivatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrivPostProvider(),
      builder: (context, child) => Consumer<PrivPostProvider>(
        builder: (context, algo, child) => Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
          
                      //   color: Colors.red,
                      child: const Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child:
                                  Icon(size: 50, color: Colors.green, Icons.link)),
                          Expanded(
                            //     width: MediaQuery.of(context).size.width,
                            child: TextField(
                              style: TextStyle(),
                              decoration: InputDecoration(hintText: "Post a link"),
                            ),
                          )
                        ],
                      ),
                      ),
                ),
                     InkWell(
                  onTap: () async{print("TAPPED");
                 await algo.processPrivatePost();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: 200,
                    height: 200,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [Icon(size: 40, Icons.photo_camera),
                      Text("Post a picture from your gallery",textAlign: TextAlign.center,)],
          
                    ),
                  ),
                ),
                PostButton(onPressed: (){

                })
                ,SizedBox(height: 8,)
           
              ],
            ),
          ),
        ),
      ),
    );
  }
}
