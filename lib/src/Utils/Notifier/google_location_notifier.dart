import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_demo/src/Constant/app_keys.dart';
import 'package:googlemap_demo/src/Constant/app_urls.dart';
import 'package:googlemap_demo/src/Element/textfield_class.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../../Page/GoogleLocation/google_Map_Screen_vc.dart';
import '../../Page/GoogleLocation/search_location.dart';
import '../../Page/GoogleLocation/show_places_method.dart';


class MapNotifier extends ChangeNotifier{

  LatLng? latLng;
  LatLng? addressLatLng;
  final List<Marker> markers = <Marker>[];

  bool? serviceEnabled;
  LocationPermission? permission;
  bool isInAsyncCall = false;
  bool addressLat = false;
  bool selectLong = false;

  GoogleMapController? controller;

  var uuid =  const Uuid();
  String? sessionToken;
  List<dynamic> placeList = [];

  String? kPlacesApiKey;
  String? baseURL;
  String? request;
  String? input;

  CameraUpdate? update;
  Position? currentLocation;

  double? latitude;
  double? longitude;
  var position;

  onCameraPosition() {
    CameraPosition(
      target: latLng ?? const LatLng(0, 0),
      // target: state.selectLong == false ? state.latLng! : state.addressLatLng!,
      zoom: 14.4746,
    );
  }

  getCurrentLatLong()async{
    // isInAsyncCall = true;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return ('error');
      }
    }

    if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return ('error');
    }
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latLng = LatLng(position.latitude, position.longitude);
    // latLng = selectLong == false ? LatLng(position.latitude, position.longitude) : addressLatLng;
    //isInAsyncCall = false;
    addMarker();
    notifyListeners();
  }
  ///this method use is a marker set in google map
  addMarker()async{
    isInAsyncCall = true;
    markers.add(Marker(
        markerId: const MarkerId(MapKey.markerId),
        position: latLng!,
        //  position: selectLong == false ? latLng! : addressLatLng!,
        icon: BitmapDescriptor.defaultMarker
    )
    );
    print("marker $latLng");
    // print(addressLatLng);
    // isInAsyncCall = false;
    latLongToGetAddress();
    //addressToGetLatLong();
    notifyListeners();
  }
  ///this method use is a check sessionToken is not null and use in a get suggestion method
  onChanged(state, context) {
    sessionToken ??= uuid.v4();
    input = SearchTextFields.searchcontroller.text;
    getSearchPlacesMethod(state, context);
    notifyListeners();
  }
  ///this method use in a search place and this method use is a search place screen
  void getSearchPlacesMethod(state,context) async {
    kPlacesApiKey = MapKey.mapKey;
    baseURL = URLs.baseUrl;
    request = '$baseURL?input=$input&key=$kPlacesApiKey&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request!));
    if (response.statusCode == 200) {
      placeList = json.decode(response.body)[PlacesSearchKey.predictions];
      placeList.add(int.parse(json.decode(response.body)[PlacesSearchKey.predictions].toString()));
    } else {
     print('error');
    }
    showPlacesMethod(state, context);
    notifyListeners();
  }

  ///this method use is latLong to find address this method use in add Marker method
  latLongToGetAddress()async{
    addressLat = false;
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: latLng!.latitude,
        longitude: latLng!.longitude,
        googleMapApiKey: MapKey.mapKey);
    SearchTextFields.searchcontroller.text =  data.address;
  }

  ///this method use is address to find latLong
  addressToGetLatLong()async{
    if(SearchTextFields.searchcontroller.text.isNotEmpty)
    {
      addressLat = true;
      GeoData data = await Geocoder2.getDataFromAddress(address: SearchTextFields.searchcontroller.text, googleMapApiKey: MapKey.mapKey);
      //addressLatLng = LatLng(data.latitude, data.longitude);
      latLng = LatLng(data.latitude, data.longitude);
      controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng!)));
      addMarker();
      notifyListeners();
    }
    else
    {
      print('error');
    }
    notifyListeners();
  }

  ///this method use is a navigate to search screen and use in module->search method file
  navigateToSearchPlaceScreen(context){
    SearchTextFields.searchcontroller.text = "";
    Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchPlacesScreen()));
  }

  ///this method use is a navigate to search screen and use in search place screen
  navigateToMapScreen(context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>MapScreen()));
  }

  navigatorPop(context){
    Navigator.pop(context);
  }

  initializeMapScreen(){
    getCurrentLatLong();
  }
}
