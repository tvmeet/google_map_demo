import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_demo/src/Element/padding_class.dart';
import 'package:googlemap_demo/src/Element/textfield_class.dart';
import 'package:googlemap_demo/src/Utils/Notifier/google_location_notifier.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
GoogleMapScreen()=>ChangeNotifierProvider<GoogleLocationNotifier>(create: (_)=>GoogleLocationNotifier(), child: const GoogleMapScreenProvider(),);

class GoogleMapScreenProvider extends StatefulWidget {
  const GoogleMapScreenProvider({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreenProvider> createState() => _GoogleMapScreenProviderState();
}

class _GoogleMapScreenProviderState extends State<GoogleMapScreenProvider> {
  String? raceLatitude, raceLongitude;
  String? isFlag;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     /// Provider.of<GoogleLocationNotifier>(context, listen: false).getSuggestion();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleLocationNotifier>(
      builder: (context, state, child){
        return SafeArea(
            child: Scaffold(
              // appBar: AppBar(
              //   centerTitle: true,
              //   title: const Text('Google Location API'),
              // ),
               body:Stack(
                 children: [
                   GoogleMap(
                       zoomGesturesEnabled: true,
                       initialCameraPosition: CameraPosition(
                          target: state.startLocation,
                           zoom:14.0
                       ),
                     mapType: MapType.normal,
                     onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        state.controller.complete(controller);
                      });
                     },
                   ),
                   Padding(
                     ////padding: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                     child: Column(
                       children: [
                         TextField(
                           controller: SearchTextFields.searchcontroller,
                           onChanged: state.onChanged,
                           decoration: InputDecoration(
                               contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.grey)),
                               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.black)),
                              /// errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                              //// focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                               hintText: 'Search',
                               prefixIcon: const Icon(
                                 Icons.search,
                                 size: 30,
                                 color: Colors.black,
                               ),
                               hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                               filled: true,
                               fillColor: Colors.white70,
                               border: InputBorder.none,
                               suffixIcon:  SearchTextFields.searchcontroller.text.isNotEmpty
                                   ?IconButton(onPressed: (){
                                 setState(() {
                                   SearchTextFields.searchcontroller.clear();
                                 });
                               }, icon:const Icon(Icons.clear_rounded),
                               ): null
                           ),

                         ),
                         Expanded(
                             child: ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: state.placeList.length,
                                 itemBuilder: (context, index){
                                   return GestureDetector(
                                     onTap: (){
                                       SearchTextFields.searchcontroller.text = state.placeList[index]['description'];
                                     _getLatLong();
                                     },
                                     child: Container(
                                       color: Colors.white70,
                                       child: ListTile(
                                         contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                         leading: Container(
                                           padding: const EdgeInsets.only(right: 10.0),
                                           decoration: const BoxDecoration(
                                               border: Border(
                                                   right: BorderSide(width: 2.0, color: Colors.black))),
                                           child: const Icon(Icons.location_on_sharp, color: Colors.blue),
                                         ),
                                         title: Text(state.placeList[index]['description']),
                                       ),
                                     ),
                                   );

                                 })
                         )
                       ],
                     ),
                   ),
                 ],
               )
            ),
        );
      },
    );
  }
  Future<bool> _getLatLong() async {
    try {
      List<Location> startPlacemark = await locationFromAddress( SearchTextFields.searchcontroller.text);
      double startLatitude = startPlacemark[0].latitude;
      double startLongitude = startPlacemark[0].longitude;
      raceLatitude = startLatitude.toString();
      raceLongitude = startLongitude.toString();
      if(isFlag == "source"){
        var raceStartLat = raceLatitude;
        var raceStartLong = raceLongitude;
      }else{
        var raceFinishLat = raceLatitude;
        var raceFinishLong = raceLongitude;
      }
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
