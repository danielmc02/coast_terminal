import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
class PrivPostProvider  extends ChangeNotifier
{
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
}