import 'package:coast_terminal/api_service.dart';
import 'package:coast_terminal/models/contract_consent_certificate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../constants/boxes.dart';

class ConsentProvider extends ChangeNotifier {
  PageController pageController = PageController();
  ConsentProvider();
  bool hasConfirmedLocation = false;
  bool choseOcc = false;
  bool choseGwc = false;
  bool? optInCCPA = true;
  String school = "";
  bool isOnLastPage = false;
  var extrovert = ["#Gym", "#Sports", "#Cars", "#Business"];
  var introvert = ["#Studying", "#Active", "#Sports", "#Health"];

  bool extrovertedCat = false;
  bool introvertedCat = false;
  Future<void> pickedCategory(int i) async {
    switch (i) {
      case 1:
        print("Extroverted chosen");
        extrovertedCat = true;
        introvertedCat = false;
        notifyListeners();
        break;
      case 2:
        print("Introverted chosen");
        extrovertedCat = false;
        introvertedCat = true;
        notifyListeners();
        break;
      default:
        print("error");
        break;
    }
  }

  String headerTitle = "What school do you go to?";
  String buttonTitle = "Next";
  void changeTitle(int i) {
    switch (i) {
      case 0:
        headerTitle = "What school do you go to?";
        buttonTitle = "Next";

        notifyListeners();
        break;
      case 1:
        headerTitle = "Pick a category";
        buttonTitle = "Confirm";
//buttonTitle = "Finish";
        notifyListeners();
        break;

      case 2:
        headerTitle = "Terms of service";
        buttonTitle = "Finish";
        notifyListeners();
        break;
      default:
    }
  }

  void chooseSchool(String s) {
    switch (s) {
      case "occ":
        debugPrint("Occ was chosen");
        choseGwc = false;
        choseOcc = true;
        school = "Orange Coast College";
        notifyListeners();
        break;
      case "gwc":
        debugPrint("Gwc was chosen");
        choseOcc = false;
        choseGwc = true;
        school = "Golden West College";
        notifyListeners();
        break;
    }
  }

  Future<void> finishConsent() async {
    print("The user CCPA status is: $optInCCPA , and school is $school");
    final cert = ContractConsentCertificate(optInCCPA!, school);
    if (Boxes.getCertificate().get('currentCert') == null) {
      print("No certificates exist, creating new one");
      await Boxes.getCertificate().put('currentCert', cert);
    } else {
      await Boxes.getCertificate().delete('currentCert');

      await Boxes.getCertificate().put('currentCert', cert);
    }
    await ApiService.instance!.signInAnon();
  }

  Future<void> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("Service Enabled: $serviceEnabled");
    if (serviceEnabled == false) {
      // ignore: use_build_context_synchronously
      await showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Your location is disabled"),
              content: Text(
                  "To ensure that you are on a compatible campus, we kindly request users to enable their location services at this time. This allows us to verify your location and ensure that you have seamless access to all the features"),
            );
          });
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
      print("always enabled");
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
        bool isAtGwc = goldenWestCollegeArea.contains(LatLng(latitude, longitude));

        LatLngBounds orangeCoastCollegeArea = LatLngBounds(
            LatLng(33.675449, -117.918283), LatLng(33.667382, -117.907604));

        LatLngBounds homeDad = LatLngBounds(
            LatLng(33.67774, -117.951247), LatLng(33.677386, -117.951004));
        bool isAtHome = homeDad.contains(LatLng(latitude, longitude));
        bool isAtOcc =
            orangeCoastCollegeArea.contains(LatLng(latitude, longitude));
            if((isAtOcc || isAtHome) && choseOcc)
            {
              await pageController.nextPage( duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                      print("Valid");
            }
            else if(/*( */isAtGwc /*|| isAtHome)*/ && choseGwc)
            {
              await pageController.nextPage( duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                      print("Valid");
            }
            else
            {
              print("error in location");
                                   showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    SizedBox(
                                        //   color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Color.fromARGB(255, 224, 202, 0)),
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
                                            child: const Text("Okay")))
                                  ],
                                  //alignment: Alignment.center,

                                  content: const Text(
"It seems that we can't verify that you are within your campus perimeter. Please make sure that you are on campus when you press \"confirm\" "
,                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text(
                                    "Uh oh",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ));
            
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
        bool isAtGwc = goldenWestCollegeArea.contains(LatLng(latitude, longitude));

        LatLngBounds orangeCoastCollegeArea = LatLngBounds(
            LatLng(33.675449, -117.918283), LatLng(33.667382, -117.907604));

        LatLngBounds homeDad = LatLngBounds(
            LatLng(33.67774, -117.951247), LatLng(33.677386, -117.951004));
        bool isAtHome = homeDad.contains(LatLng(latitude, longitude));
        bool isAtOcc =
            orangeCoastCollegeArea.contains(LatLng(latitude, longitude));
            if(( isAtOcc || isAtHome) && choseOcc)
            {
              await pageController.nextPage( duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                      print("Valid");
            }
            else if(/*( */isAtGwc /*|| isAtHome)*/ && choseGwc)
            {
              await pageController.nextPage( duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.linear);
                                      print("Valid");
            }
            else
            {
              print("error in location");
                                  showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    SizedBox(
                                        //   color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                      Color.fromARGB(255, 224, 202, 0)),
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
                                            child: const Text("Okay")))
                                  ],
                                  //alignment: Alignment.center,

                                  content: const Text(
"It seems that we can't verify that you are within your campus perimeter. Please make sure that you are on campus when you press \"confirm\" "
,                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text(
                                    "Uh oh",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ));
              
            }
     
    }
  }
}
