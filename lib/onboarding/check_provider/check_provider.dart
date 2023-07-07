import 'dart:io';

import 'package:coast_terminal/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:latlong2/latlong.dart';

class CheckProvider extends ChangeNotifier {
  String preButton = "Continue";
  bool popScope = true;
  bool isLoadingProcess = false;
  bool passedLocation = false;
/*
  Future<void> check() async {
    popScope = false;
    isLoadingProcess = true;
        notifyListeners();

await Future.delayed(Duration(seconds: 1));

    //init reqs
    //
    try
    {
          bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
   } else if (permission == LocationPermission.denied) {
      print("Denied permission");
      final newPermission = await Geolocator.requestPermission();
      print("$newPermission tststs");
      if (newPermission == LocationPermission.whileInUse ||
          newPermission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double latitude = position.latitude;
        double longitude = position.longitude;
        print("current location is:\nLat:$latitude\nLong:$longitude");
        LatLngBounds goldenWestCollegeArea = LatLngBounds(
            LatLng(33.737299, -118.006907), LatLng(33.73008, -117.997999));
        bool isAtGwc =
            goldenWestCollegeArea.contains(LatLng(latitude, longitude));

        LatLngBounds orangeCoastCollegeArea = LatLngBounds(
            LatLng(33.675449, -117.918283), LatLng(33.667382, -117.907604));

        LatLngBounds homeDad = LatLngBounds(
            LatLng(33.67774, -117.951247), LatLng(33.677386, -117.951004));
        bool isAtHome = homeDad.contains(LatLng(latitude, longitude));
        bool isAtOcc =
            orangeCoastCollegeArea.contains(LatLng(latitude, longitude));
        if ((isAtOcc || isAtHome || isAtGwc)) {
        passedLocation = true;

        } else {
          print("error no locations match");
          throw "ERROR IN LOCATION";

        }
      }
    } else if (permission == LocationPermission.deniedForever) {
      print("Denied forever");
      //since it's denied lets request
    } else if (permission == LocationPermission.unableToDetermine) {
      print("unable to determine");
    } else if (permission == LocationPermission.whileInUse) {
      print("Only while in use");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;
      print("current location is:\nLat:$latitude\nLong:$longitude");

      LatLngBounds goldenWestCollegeArea = LatLngBounds(
          LatLng(33.737299, -118.006907), LatLng(33.73008, -117.997999));
      bool isAtGwc =
          goldenWestCollegeArea.contains(LatLng(latitude, longitude));

      LatLngBounds orangeCoastCollegeArea = LatLngBounds(
          LatLng(33.675449, -117.918283), LatLng(33.667382, -117.907604));

      LatLngBounds homeDad = LatLngBounds(
          LatLng(33.67774, -117.951247), LatLng(33.677386, -117.951004));
      bool isAtHome = homeDad.contains(LatLng(latitude, longitude));
      bool isAtOcc =
          orangeCoastCollegeArea.contains(LatLng(latitude, longitude));
      if ((isAtOcc || isAtHome || isAtGwc)) {
        passedLocation = true;
      } else {
        print("error in locations");
        throw "ERROR IN LOCATION";
      }
    }
    notifyListeners();
    }
    catch(e)
    {
      print(e);

    preButton = "Retry";
    isLoadingProcess = false;
    popScope = true;
    campusStatus = "Enable precise location in settings";
    notifyListeners();
    }

  }
  String campusStatus = "On a verified campus?";
*/



  bool? locationPass;
  bool? progLoad;
  bool? adPass;
  /*
  Future<void> check2(BuildContext context) async {
        progLoad = true;

    popScope = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    //

    LatLngBounds goldenWestCollegeArea = LatLngBounds(
        LatLng(33.737299, -118.006907), LatLng(33.73008, -117.997999));

    LatLngBounds orangeCoastCollegeArea = LatLngBounds(
        LatLng(33.675449, -117.918283), LatLng(33.667382, -117.907604));

    LatLngBounds homeDad = LatLngBounds(
        LatLng(33.67774, -117.951247), LatLng(33.677386, -117.951004));

    ///
    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        serviceEnabled == false ? throw "DENIED" : null;
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        permissionGranted == PermissionStatus.denied ||
                permissionGranted == PermissionStatus.deniedForever
            ? throw "denied"
            : null;
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      locationData = await location.getLocation();
      bool isAtHq = homeDad
          .contains(LatLng(locationData.latitude!, locationData.longitude!));

      bool isAtOcc = orangeCoastCollegeArea
          .contains(LatLng(locationData.latitude!, locationData.longitude!));

      bool isAtGwc = goldenWestCollegeArea
          .contains(LatLng(locationData.latitude!, locationData.longitude!));
      print("Home: $isAtHq");
      print("OCC: $isAtOcc");
      print("GWC: $isAtGwc");
      
      //is at gwc or hq
      if(isAtGwc /* || isAtHq */)
      {
      locationPass = true;

      }
      else if(isAtOcc /* || isAtHq */)
      {
      locationPass = true;

      }
      else
      {
        throw "No location found";
      }
          notifyListeners();

    } catch (e) {
      print("There was an error in location rendering: $e");
      locationPass = false;
      progLoad = false;
      preButton = "Try Again";
      popScope = true;
          notifyListeners();
  return;
    }

//ad time
    try {
      print("Running ad setup");
      RewardedAd? rewardedAd;

      final adUnitId = Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';
      await RewardedAd.load(
          adUnitId: adUnitId,
          request: const AdRequest(),
          rewardedAdLoadCallback:
              RewardedAdLoadCallback(onAdLoaded: (ad) async {
            rewardedAd = ad;
            print("AD: $ad");
            print("Rewarded ad is $rewardedAd");

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) async {
                /*
              print('ad dismissed full screen content.');
                            */

                ad.dispose();
                                                await ApiService.instance!.signInAnon();

                Navigator.pop(context);
               // await ApiService.instance!.signInAnon();
              },
            );
            print('$ad loaded');
            print("DONE");
            adPass = true;
            notifyListeners();
            print("If ad is null : $rewardedAd");
            await Future.delayed(const Duration(seconds: 1));
//popScope = true;
            await rewardedAd!.show(
              onUserEarnedReward: (ad, reward) async{

                print("Award");
              },
            );
          }, onAdFailedToLoad: (LoadAdError error) {
            print(error);
            throw error;
          }));

//_rewardedAd!.show(onUserEarnedReward: (AdWithoutView,item){print("$AdWithoutView & $item");});
    } catch (e) {
      print("Ad Error: $e");
      adPass = false;
      notifyListeners();
      return;
    }
  } 
  */
}
