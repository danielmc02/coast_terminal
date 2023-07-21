import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
class PrivPostProvider  extends ChangeNotifier
{
  late ImagePicker picker;
  PrivPostProvider()
  {
    print("INIT FOR PRIV");
     picker = ImagePicker();
  }

  Future<void> processPrivatePost() async
  {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  }
}