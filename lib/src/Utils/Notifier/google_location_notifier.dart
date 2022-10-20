import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:googlemap_demo/src/Element/textfield_class.dart';
import 'package:googlemap_demo/src/Constant/app_keys.dart';
import '../../Constant/app_urls.dart';
import 'dart:convert';

class GoogleLocationNotifier extends ChangeNotifier{
  // LatLng? latLng;
  // final List<Marker> markers = <Marker>[];
  // final List<LatLng> latLong = <LatLng>[
  //   const LatLng(21.5222, 70.4579),
  //   const LatLng(22.3039, 70.8022 ),
  //   const LatLng(21.1702, 72.8311),
  // ];


  String? dummyInitText;
  bool? isLoading;

  bool? serviceEnabled;
  LocationPermission? permission;
  bool isInAsyncCall = false;

  Completer<GoogleMapController> controller = Completer();

  var uuid =  const Uuid();
  String? sessionToken;
  List<dynamic> placeList = [];

  String? kPlacesApiKey;
  String? baseURL;
  String? request;
  String? input;

  onChanged() {
    sessionToken ??= uuid.v4();
    input = SearchTextFields.searchcontroller.text;
    getSuggestion();
    notifyListeners();
  }

  void getSuggestion() async {
    kPlacesApiKey = googleMapKEYs.kPLACES_API_KEY ;
    baseURL = URLs.baseUrl;
    request = '$baseURL?input=$input&key=$kPlacesApiKey&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request!));
    if (response.statusCode == 200) {
      placeList = json.decode(response.body)['predictions'];
      placeList.add(int.parse(json.decode(response.body)['predictions']));
    } else {
      throw Exception('Failed to load predictions');
    }
  }
  initialiseHomeScreen()async{
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 800));
    dummyInitText = 'Test';
    isLoading = false;
    notifyListeners();
  }
}


