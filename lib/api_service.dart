import 'dart:async';

import 'package:coast_terminal/models/message.dart';
import 'package:coast_terminal/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/boxes.dart';
import 'home/provider/home_provider.dart';

class ApiService {
  static ApiService? _instance;
  static FirebaseAuth? _auth;
  static User? _user;
  static FirebaseDatabase? _database;
  static DatabaseReference? _messagesDatabase;
  static DatabaseReference? _messageCount;

  ApiService._internal() {
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    _database = FirebaseDatabase.instance;
    _messagesDatabase = _database!.ref('messages');
    _messageCount = _database!.ref('count');
  }
  DatabaseReference? get messagesDatabase {
    return _messagesDatabase;
  }

  FirebaseDatabase? get database {
    return _database;
  }

  DatabaseReference? get messageCount {
    return _messageCount;
  }

  static ApiService? get instance {
    _instance ??= ApiService._internal();
    return _instance;
  }

  FirebaseAuth? get auth {
    return _auth;
  }

  bool currentMessageSucessresult = false;

  //Sign in anoynomously (guest)
  Future signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      var tempUse = userCredential.user;
      final userModel = Boxes.getuser();
      if (userModel != null) {
        print(
            " An existing UserModel instance exists. There are ${userModel.values.length}. Delete it and create new one.");

        var currentUser = UserInstance(
            tempUse!.uid, false, tempUse.metadata.creationTime!, null );
        Boxes.getuser().put('mainUser', currentUser);
        return userModel;
      } else {
        print("No existing UserModel instance exists. Create a new one.");
        var currentUser = UserInstance(
            tempUse!.uid, false, tempUse.metadata.creationTime!, null);
        Boxes.getuser().put('mainUser', currentUser);
      }

      print("Signed in with TEMPORARY account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future deleteUser() async {
    await _user!.delete();
    // await FirebaseAuth.instance.currentUser!.delete();
  }

  Future signOut() async {
    await _auth!.signOut();
    // await FirebaseAuth.instance.signOut();
  }

  Stream<User?> getuser() async* {
    yield* _auth!.userChanges();
  }

  Future<int> getMessageCount() async {
    final snapshot = await _messageCount!.get();

    // _messageCount.child(path)
    print(snapshot.value);
    int count = snapshot.value as int;
    return count;
  }

  bool ref = true;
  PageController pageController = PageController();

  Widget heart() {

    return Builder(
      builder: (context) {
        return ChangeNotifierProvider(
          create: (context) => HomeProvider(),
          builder: (context, child) => Consumer<HomeProvider>(
            builder: (context, algo, child) => Column(
              children: [
                FutureBuilder(
                    future: algo.calculateIfThereAreMessages(),
                    builder: (context, snapshot) {
                      print('${snapshot.data} chchahdsfiohasfdsafasd');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height/2,
                            child: snapshot.data != null
                                ? ifThereIsMessagePromptIt2()
                                : Text(
                                    "UH OH, there are no messages",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                    ),
                                  ),
                          );

                        default:
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                      }
                    }),
                Column(
                  children: [
                    Row(
                      children: [Text('My Messages:'),
                     // Boxes.getuser().get('mainUser')!.hasPostedMessage == true ? Text('${Boxes.getuser().get('mainUser')!.messageInstances.length}') : Text('has no messages')
                      ],
                    ),
                    /*
                    for(var e in Boxes.getuser().get('mainUser')!.messageInstances)
                    Container(color: Colors.white,
                      child: SizedBox(width: 250,height: 60,child: ListTile(title: Text(e.title),leading:CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 30,
                                foregroundImage: iconReferences[Boxes.getMessage()
                                    .get('currentMessage')!
                                    .iconIndex]) ,),),
                    )
                      */
                  

                
           
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget ifThereIsMessagePromptIt() {
    print('nigger');
    return ListTile(
        subtitle: Text(
            style: TextStyle(color: Colors.white),
            Boxes.getMessage().get('currentMessage')!.message),
        leading: CircleAvatar(
            foregroundImage: iconReferences[
                Boxes.getMessage().get('currentMessage')!.iconIndex]),
        title: Text(Boxes.getMessage().get('currentMessage')!.title));
  }

  Widget ifThereIsMessagePromptIt2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(builder: (context) {
        return Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 20,
          color: Colors.transparent,
          child: Ink(
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(105, 0, 0, 0), width: 1),
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 252, 252, 252),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              foregroundImage: iconReferences[Boxes.getMessage()
                                  .get('currentMessage')!
                                  .iconIndex]),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: FittedBox(
                                child: Text(
                                  Boxes.getMessage()
                                      .get('currentMessage')!
                                      .title,
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          //color:Colors.green,
                          width: MediaQuery.of(context).size.width,
                          child: Scrollbar(
                            thumbVisibility: false,
                            child: SingleChildScrollView(
                              child: Text(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  Boxes.getMessage()
                                      .get('currentMessage')!
                                      .message),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // onTap: () {},
            ),
          ),
        );
      }),
    );
  }

  List iconReferences = const [
    AssetImage('assets/face_icons/anonymous.png'),
    AssetImage('assets/face_icons/occ.jpeg'),
    AssetImage('assets/face_icons/angel.png'),
    AssetImage('assets/face_icons/angry.png'),
    AssetImage('assets/face_icons/cool.png'),
    AssetImage('assets/face_icons/cry.png'),
    AssetImage('assets/face_icons/dead.png'),
    AssetImage('assets/face_icons/demon.png'),
    AssetImage('assets/face_icons/disappointed.png'),
    AssetImage('assets/face_icons/exhale.png'),
    AssetImage('assets/face_icons/frustrated.png'),
    AssetImage('assets/face_icons/happy.png'),
    AssetImage('assets/face_icons/hide.png'),
    AssetImage('assets/face_icons/love.png'),
    AssetImage('assets/face_icons/mask.png'),
    AssetImage('assets/face_icons/neutral.png'),
    AssetImage('assets/face_icons/scared.png'),
    AssetImage('assets/face_icons/shock.png'),
    AssetImage('assets/face_icons/sus.png')
  ];
}
