import 'dart:math';

import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/models/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../constants/boxes.dart';
import 'package:geolocator/geolocator.dart';

class HomeProvider extends ChangeNotifier {
  double progress = 0;
  String status = "Loading";
  HomeProvider() {
    _init();
  }
  _init() async {}
Future<void> updateStats(String? stat, double? prog) async
{
  stat == null ? null : status = stat;
    prog == null ? null : progress = prog;
    notifyListeners();

}
  Future<void> HomeBuild(BuildContext context) async {
    print("running home functions---");
    print("checking that you are in the right location");
   await updateStats("Checking that you are at an eligible campus", null);
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print(serviceEnabled);
    if (serviceEnabled == false) {
      // ignore: use_build_context_synchronously
      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Your location is disabled"),
              content: Text(
                  "To ensure that you are on a compatible campus, we kindly request users to enable their location services. This allows us to verify your location and ensure that you have seamless access to all the features"),
            );
          });
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;
      print("current location is:\nLat:$latitude\nLong:$longitude");
      print(position);
      LatLngBounds orangeCoastCollegeArea = LatLngBounds(
          LatLng(33.675449, -117.918283), LatLng(33.667382, -117.907604));
      LatLngBounds homeDad = LatLngBounds(
          LatLng(33.67774, -117.951247), LatLng(33.677386, -117.951004));
      bool isAtHome = homeDad.contains(LatLng(latitude, longitude));
      bool isAtOcc =
          orangeCoastCollegeArea.contains(LatLng(latitude, longitude));
      isAtHome == true
          ? print("IT KNOWS IM AT HOMEEE")
          : print("Is not at occ");

      isAtHome == true
          ? print("IT KNOWS IM AT HOMEEE")
          : print("Is not at home");
          progress = 0.5;
          notifyListeners();
        await  Future.delayed(Duration(seconds: 4));
      //run the necessary functions before displaying home
      //The first one will be checking if a current message exists and if you need to delete it if it hit max view
      //This is good because you can update the message even if you dont want to remove it
      status = "Updating messages";
      notifyListeners();
      print("Updating any existing messages");
      if (Boxes.getMessage().get('currentMessage') != null) {
        String currentMessageKey =
            Boxes.getMessage().get('currentMessage')!.uidAdmin.toString();
        print('current message key is $currentMessageKey');
        try {
          await ApiService.instance!.keys!
              .child(currentMessageKey)
              .once()
              .then((value) {
            Map spec = value.snapshot.value as Map;
          });
        } catch (e) {
          print("uhohhh, The error must not exist anymore... delete it, $e");
          await Boxes.getMessage().get('currentMessage')!.delete();
          print(
              "current message has been deleteddd, ${Boxes.getMessage().get('currentMessage')!.message} ");
        }
      }
      progress = 1.0;
      status = "done";
      notifyListeners();
      await Future.delayed(Duration(seconds: 3));
    }
  }
}
