// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:googlemap_demo/src/Utils/Notifier/google_map_notifier.dart';
import 'package:provider/provider.dart';
import 'map_utils.dart';

MapScreen()=>ChangeNotifierProvider<GoogleMapNotifier>(create: (_)=>GoogleMapNotifier(),child: MapScreenProvider(),);


class MapScreenProvider extends StatefulWidget {
  const MapScreenProvider({Key? key,}) : super(key: key);
  @override
  State<MapScreenProvider> createState() => _MapScreenProviderState();
}

class _MapScreenProviderState extends State<MapScreenProvider> {
  //
  // final startSearchFieldController =  TextEditingController();
  // ////final enadSearchFieldController = TextEditingController();
  //
  // DetailsResult? startPosition;
  // DetailsResult? endPosition;
  //
  // late FocusNode startFocusNode;
  // /// late FocusNode endFocusNode;
  //
  // List<AutocompletePrediction> predictions = [];
  // Timer? _debounce;
  // late GooglePlace googlePlace;
  //
  // // @override
  // // void initState(){
  // //   super.initState();
  // //   String apiKey = 'AIzaSyBoz3j8mkWt64YQYLNEEln3Eg0mUMRJ-2I';
  // //   googlePlace = GooglePlace(apiKey);
  // //
  // //   startFocusNode = FocusNode();
  // //   /// endFocusNode = FocusNode();
  // // }
  //
  // void dispose(){
  //   super.dispose();
  //   startFocusNode.dispose();
  //   ///endFocusNode.dispose();
  // }
  //
  // void autoCompleteSearch(String value)async{
  //   var result = await googlePlace.autocomplete.get(value);
  //   print(result);
  //   if (result != null && result.predictions != null && mounted)
  //   {
  //     print(result.predictions!.first.description);
  //     setState(() {
  //       predictions = result.predictions!;
  //     });
  //   }
  // }
  // @override
  // void initState(){
  //   super.initState();
  //   String apiKey = 'AIzaSyBoz3j8mkWt64YQYLNEEln3Eg0mUMRJ-2I';
  //   googlePlace = GooglePlace(apiKey);
  //   startFocusNode = FocusNode();
  //   _initialPosition = CameraPosition(
  //     target: LatLng(widget.startPosition!.geometry!.location!.lat!,
  //         widget.startPosition!.geometry!.location!.lng!),
  //     zoom: 10.4746,
  //   );
  //
  // }
  late CameraPosition _initialPosition;

  DetailsResult? startPosition;
  DetailsResult? endPosition;
   
  @override
  void initState() {
    super.initState();

    _initialPosition = CameraPosition(
      target: LatLng(startPosition!.geometry!.location!.lat!,
          startPosition!.geometry!.location!.lng!),
      zoom: 10.4746,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var state = Provider.of<GoogleMapNotifier>(context,listen: false);
      state.autoCompleteSearch(toString());

    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
        markerId:  const MarkerId('start'),
        position: LatLng(startPosition!.geometry!.location!.lat!,
                         startPosition!.geometry!.location!.lng!),
      ),
    };

    return Consumer<GoogleMapNotifier>(
        builder:(context, state, child){
          return Scaffold(
              body: Stack(
                children: <Widget> [
                  GoogleMap(
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                              () => PanGestureRecognizer())),
                    zoomControlsEnabled: true,
                    initialCameraPosition: _initialPosition,
                    onMapCreated: (GoogleMapController controller) {
                      Future.delayed(
                          const Duration(milliseconds: 200),
                              () => controller.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  MapUtils.boundsFromLatLngList(
                                      _markers.map((loc) => loc.position).toList()),
                                  1)));
                    },
                    markers: Set.from(
                      _markers,
                    ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.predictions.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(
                                Icons.pin_drop
                            ),
                          ),
                          title: (
                              Text(
                                  state.predictions[index].description.toString())
                          ),
                          onTap: () async {
                            final placeId = state.predictions[index].placeId!;
                            final details = await state.googlePlace.details.get(placeId);
                            if(details != null && details.result != null && mounted)
                            {
                              if(state.startFocusNode.hasFocus){
                                setState(() {
                                  state.startPosition = details.result;
                                  state.startSearchFieldController.text = details.result!.name!;
                                  state.predictions = [];
                                });
                              }
                            }
                          },
                        );
                      }
                  ),
                ],
              )
          );
    });
  }
}
