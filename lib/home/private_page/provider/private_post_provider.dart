import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
class PrivPostProvider  extends ChangeNotifier
{
  double sliderValue = 5.0;
  late ImagePicker picker;
    File? image;
  PrivPostProvider()
  {

    print("INIT FOR PRIV");
     picker = ImagePicker();
  }

  Future<void> processPictureUpload() async
  {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery,maxWidth: 1080,maxHeight: 1800);

    print("GOT");

    pickedFile != null ? image = File(pickedFile.path) : null;
    notifyListeners();
  }


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
    
    if(isValidUrl)
    {
      urlValue = value;
      notifyListeners();
    }
    
  }
    TextEditingController urlController = TextEditingController();
  bool isValidUrl = true;
  String urlValue = "";
}