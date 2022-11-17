import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_demo/src/Page/GoogleLocation/show_places_method.dart';
import 'package:provider/provider.dart';

import '../../Utils/Notifier/google_location_notifier.dart';
import 'map_screen_search_method.dart';

MapScreen() => ChangeNotifierProvider<MapNotifier>(create: (_)=>MapNotifier(),child:const MapScreenProvider(),);

class MapScreenProvider extends StatefulWidget {
  const MapScreenProvider({Key? key}) : super(key: key);

  @override
  State<MapScreenProvider> createState() => _MapScreenProviderState();
}
class _MapScreenProviderState extends State<MapScreenProvider> {

  @override
  void initState() {
    super.initState();
    var state = Provider.of<MapNotifier>(context, listen: false);
    state.initializeMapScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MapNotifier>(
        builder: (context,state,child) {
      return Scaffold(
          body: Stack(
          children: [
          GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
          target: state.latLng ?? const LatLng(0, 0),
    // target: state.selectLong == false ? state.latLng! : state.addressLatLng!,
    zoom: 14.4746,
    ),
            markers: Set<Marker>.of(state.markers),
            onMapCreated: (GoogleMapController controller)
            {
              state.controller;
              //state.controller.complete(controller);
            },
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            onCameraMove: (CameraPosition position){
              state.latLng = position.target;
              state.addMarker();
              // state.onChanged(state, context);
            },
          ),
            searchMethodMapScreen(state, context),
            showPlacesMethod(state, context)
          ],
          ),
      );
        }
    );
  }
}
