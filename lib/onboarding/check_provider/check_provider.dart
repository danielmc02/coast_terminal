import 'dart:io';

import 'package:coast_terminal/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position? p;
    await Geolocator.getCurrentPosition(
            timeLimit: const Duration(seconds: 15),
            desiredAccuracy: LocationAccuracy.best)
        .then((value) => p = value);
    return p!;
  }

  bool? locationPass;
  bool? progLoad;
  bool? adPass;

  Future<void> check2(BuildContext context) async {
    progLoad = true;

    popScope = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    bool serviceEnabled;
    //

    LatLngBounds goldenWestCollegeArea = LatLngBounds(
        const LatLng(33.737299, -118.006907),
        const LatLng(33.73008, -117.997999));

    LatLngBounds orangeCoastCollegeArea = LatLngBounds(
        const LatLng(33.675449, -117.918283),
        const LatLng(33.667382, -117.907604));

    LatLngBounds homeDad = LatLngBounds(const LatLng(33.67774, -117.951247),
        const LatLng(33.677386, -117.951004));

    ///
    try {
      final Position position = await _determinePosition();
      print("Got loc");

      bool isAtHq =
          homeDad.contains(LatLng(position.latitude, position.longitude));

      bool isAtOcc = orangeCoastCollegeArea
          .contains(LatLng(position.latitude, position.longitude));

      bool isAtGwc = goldenWestCollegeArea
          .contains(LatLng(position.latitude, position.longitude));
      print("Home: $isAtHq");
      print("OCC: $isAtOcc");
      print("GWC: $isAtGwc");
      print("Lat: ${position.latitude}\nLong: ${position.longitude}");
      //is at gwc or hq
      //  if(isAtGwc /* || isAtHq */)
      if (isAtGwc || isAtHq || isAtOcc || true) {
        locationPass = true;
        print("PPPAAASSED: AT ONE OF THE COMPATIBLE LOCATIONS");
      } else if (isAtOcc == false || isAtGwc == false ||
          isAtHq ==
              false) //remove isathq = false because this is only to access when not on valid location
      {
        throw "No location found";
      } else {
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

/*
Prod
      final adUnitId = Platform.isAndroid
          ? 'ca-app-pub-3530957535788194/2672039372'
          : 'ca-app-pub-3530957535788194/4368264427';
*/
/*
Test
    final adUnitId = Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';
*/
      
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
              onUserEarnedReward: (ad, reward) async {
                print("Award");
              },
            );
          }, onAdFailedToLoad: (LoadAdError error) {
            print(error);
            adPass = false;
                progLoad = false;
      preButton = "Try Again";
      popScope = true;
            notifyListeners();

            throw error;
          }));

//_rewardedAd!.show(onUserEarnedReward: (AdWithoutView,item){print("$AdWithoutView & $item");});
    } catch (e) {
      print("Ad Error: $e");
      adPass = false;
      progLoad = false;
      preButton = "Try Again";
      popScope = true;
      notifyListeners();
      return;
    }
  }
}
