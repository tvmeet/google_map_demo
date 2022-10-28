// // ignore_for_file: must_be_immutable
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:googlemap_demo/src/Constant/app_keys.dart';
// import 'package:googlemap_demo/src/Constant/app_urls.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:geocoding/geocoding.dart';
//
//
// String? raceLatitude, raceLongitude;
// class SelectLocation extends StatefulWidget {
//   late TextEditingController? textEditingController;
//   late String? lat;
//   late String? long;
//   late String? isFlag;
//
//    SelectLocation({Key? key, this.lat, this.isFlag, this.long,this.textEditingController}) : super(key: key);
//
//   @override
//   State<SelectLocation> createState() => _SelectLocationState();
// }
//
// class _SelectLocationState extends State<SelectLocation> {
//
//   Completer<GoogleMapController> controller = Completer();
//   CameraPosition? cameraPosition;
//   LatLng startLocation = const LatLng(27.6602292, 85.308027);
//   late bool isSelectLocation = false;
//   List<dynamic> _placeList = [];
//   var uuid = const Uuid();
//   String? _sessionToken;
//
//   void getSuggestion(String input) async {
//     String kPLACES_API_KEY = googleMapKEYs.kPLACES_API_KEY;
//     String type = '(regions)';
//     String baseURL = URLs.baseUrl;
//     var request = Uri.parse(
//         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken');
//     var response = await http.get(request);
//     print(response.body.toString());
//     if (response.statusCode == 200) {
//       setState(() {
//         _placeList = json.decode(response.body)['predictions'];
//       });
//     } else {
//       throw Exception('Failed to load predictions');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     widget.textEditingController?.addListener(() {
//       _onChanged();
//     });
//   }
//
//   _onChanged() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(widget.textEditingController!.text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: const Text('Google Location API'),
//           ),
//           body: Stack(
//             children: [
//               GoogleMap(
//                 zoomGesturesEnabled: true,
//                 initialCameraPosition: CameraPosition(
//                     target: startLocation,
//                     zoom: 14.0
//                 ),
//                 mapType: MapType.normal,
//                 onMapCreated: (GoogleMapController controller) {
//                   setState(() {
//                     controller;
//                   });
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: widget.textEditingController,
//                       decoration: const InputDecoration(
//                           hintText: ' Search palaces with name'
//                       ),
//                     ),
//                     isSelectLocation == true ? ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: _placeList.length,
//                           itemBuilder: (context, index){
//                             return GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   widget.textEditingController?.text =
//                                   _placeList[index]["description"];
//                                   _getLatLong();
//                                   isSelectLocation = false;
//                                 });
//                               },
//                               child: SizedBox(
//                                 height: 40,
//                                 width: double.infinity,
//                                 child: Text(_placeList[index]["description"]),
//                               ),
//                             );
//                           },
//                      ):Container(),
//                   ]
//                 )
//               ),
//             ],
//           )
//       ),
//     );
//   }
//   Future<bool> _getLatLong() async {
//     try {
//       List<Location> startPlacemark = await locationFromAddress(widget.textEditingController!.text);
//       double startLatitude = startPlacemark[0].latitude;
//       double startLongitude = startPlacemark[0].longitude;
//       raceLatitude = startLatitude.toString();
//       raceLongitude = startLongitude.toString();
//       if(widget.isFlag == "source"){
//         var raceStartLat = raceLatitude;
//         var raceStartLong = raceLongitude;
//       }else{
//         var raceFinishLat = raceLatitude;
//         var raceFinishLong = raceLongitude;
//       }
//       return true;
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }
// }
