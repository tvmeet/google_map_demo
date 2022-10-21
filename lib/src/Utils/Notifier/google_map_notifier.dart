import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class GoogleMapNotifier extends ChangeNotifier {
  late CameraPosition _initialPosition;

  final startSearchFieldController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;

  /// late FocusNode endFocusNode;

  List<AutocompletePrediction> predictions = [];
  late GooglePlace googlePlace;

  // @override
  // void initState(){
  //   super.initState();
  //   String apiKey = 'AIzaSyBoz3j8mkWt64YQYLNEEln3Eg0mUMRJ-2I';
  //   googlePlace = GooglePlace(apiKey);
  //
  //   startFocusNode = FocusNode();
  //   /// endFocusNode = FocusNode();
  // }
  void autoCompleteSearch(String value) async {
    String apiKey = 'AIzaSyBoz3j8mkWt64YQYLNEEln3Eg0mUMRJ-2I';
    googlePlace = GooglePlace(apiKey);
    startFocusNode = FocusNode();

    var result = await googlePlace.autocomplete.get(value);
    print(result);
    if (result != null && result.predictions != null) {
      print(result.predictions!.first.description);
      predictions = result.predictions!;
    }
  }

  void initState() {
    _initialPosition = CameraPosition(
      target: LatLng(startPosition!.geometry!.location!.lat!,
          startPosition!.geometry!.location!.lng!),
      zoom: 10.4746,
    );
  }
}
