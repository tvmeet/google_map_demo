import 'package:flutter/material.dart';
import 'package:googlemap_demo/src/Element/textfield_class.dart';
import '../../Constant/app_strings.dart';
import '../../Utils/Notifier/google_location_notifier.dart';

searchMethodMapScreen(MapNotifier state,context){

  return Padding(
    padding: const EdgeInsets.only(top: 60,left: 10,right: 10),
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: TextField(
          controller: SearchTextFields.searchcontroller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: MapScreenString.search,
            suffixIcon: Icon(Icons.location_on,color:Colors.black),
          ),
          onChanged:(string){
            //MapScreenTextController.places.text == "";

            // state.latLongToGetAddress();
            state.onChanged(state,context);
            // showPlacesMethod(state, context);
            },
          onTap: (){
            SearchTextFields.searchcontroller.text == "";
            //state.navigateToSearchPlaceScreen(context);
          },
        ),
      ),
    ),
  );

}