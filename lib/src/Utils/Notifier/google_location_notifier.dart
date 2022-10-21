import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:googlemap_demo/src/Element/textfield_class.dart';
import 'package:googlemap_demo/src/Constant/app_keys.dart';
import '../../Constant/app_urls.dart';


class GoogleLocationNotifier extends ChangeNotifier{
  LatLng? latLng;
  final List<Marker> markers = <Marker>[];
  final List<LatLng> latLong = <LatLng>[
    const LatLng(21.5222, 70.4579),
  ];


  String? dummyInitText;
  bool? isLoading;

  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  String location = "Search Location";

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
    final Completer<GoogleMapController> controller = Completer();
    getSuggestion();
    notifyListeners();
  }

  void getSuggestion() async {
    kPlacesApiKey = googleMapKEYs.kPLACES_API_KEY ;
    baseURL = URLs.baseUrl;
    request = '$baseURL?input=$input&key=$kPlacesApiKey&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request!));
    if (response.statusCode == 200) {
      placeList = jsonDecode(response.body.toString())['predictions'];
      print(response.body.toString());
     /// placeList.add(int.parse(json.decode(response.body)['predictions']));
    } else {
      throw Exception('Failed to load predictions');
    }
  }
}


