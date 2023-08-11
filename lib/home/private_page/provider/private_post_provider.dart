import 'dart:io';

import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/models/vip_message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/boxes.dart';

class PrivPostProvider extends ChangeNotifier {
  double sliderValue = 5.0;
  late ImagePicker picker;
  File? image;
  PrivPostProvider() {
    titleController = TextEditingController();
    messageController = TextEditingController();
    print("INIT FOR PRIV");
    picker = ImagePicker();
  }
  late TextEditingController titleController;
  late TextEditingController messageController;
  Future<void> processPictureUpload() async {
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1800);

    print("GOT");

    if (pickedFile != null) {
      image = File(pickedFile.path);
      hasPicture = true;
      costValue += 10;
      notifyListeners();
    } else {
      costValue -= 10;
      hasPicture = false;
      notifyListeners();
    }
    notifyListeners();
  }

  bool hasPicture = false;

  RegExp _urlRegex = RegExp(
    r'^(https?://)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$',
    caseSensitive: false,
    multiLine: false,
  );

  // Function to validate the URL
  bool _validateUrl(String value) {
    return _urlRegex.hasMatch(value);
  }

  void onTextChanged(String value) {
    isValidUrl = _validateUrl(value);

    if (isValidUrl) {
      hasValidUrl == false ? costValue += 10 : null;
      hasValidUrl = true;
      urlValue = value;
    }

    notifyListeners();
  }

  bool hasValidUrl = false;
  TextEditingController urlController = TextEditingController();
  bool isValidUrl = false;
  String? urlValue;
  final fromKey = GlobalKey<FormState>();

  Future<void> postVipMessage() async {
    String? URL;
    //First post picture if needed
    if (image != null) {
      try {
        final res = await ApiService.instance!.fileStorage!
            .child('vip/${DateTime.now()}')
            .putFile(image!)
            .then(
          (p0) async {
            URL = await p0.ref.getDownloadURL();
          },
        );

        print("Published an image");
      } catch (e) {
        // ...
        print(e.toString());
      }
    }
    final key = ApiService.instance!.vipMessagesDatabase!.push().key;
    await ApiService.instance!.vipMessagesDatabase!.child(key!).set({
      "Message": messageController.text,
      "Title": titleController.text,
      "PhotoUrl": image != null ? URL : null,
      "Link": urlValue != null ? urlValue : null
    });
    //create local user's vip message
    VipMessage ussersVipMessage = VipMessage(
        uidAdmin: key,
        title: titleController.text,
        message: titleController.text,
        image: image,
        imageUrl: URL,
        url: urlValue);
        Boxes.getVipMessage().put(key,ussersVipMessage);
  print(Boxes.getVipMessage().values);

    print("PUSHED");

    // ApiService.instance!.vipDatabase!.child(ApiService.instance!.auth!.currentUser!.uid).set(value)
  }

  int costValue = 40;

  Future<void> updateTitleStatus() async {
    if (titleController.text.length >= 10) {
      hasTitle = true;
      notifyListeners();
    } else {
      hasTitle = false;
      notifyListeners();
    }
  }

  bool hasTitle = false;

  Future<void> updateMessageStatus() async {
    if (messageController.text.length >= 50) {
      hasMessage = true;
      notifyListeners();
    } else {
      hasMessage = false;
      notifyListeners();
    }
  }

  bool hasMessage = false;
}
