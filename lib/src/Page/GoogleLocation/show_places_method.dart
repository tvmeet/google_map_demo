import 'package:flutter/material.dart';
import 'package:googlemap_demo/src/Element/textfield_class.dart';
import '../../Constant/app_keys.dart';
import '../../Utils/Notifier/google_location_notifier.dart';

showPlacesMethod(MapNotifier state,context){

  return Padding(
    padding: const EdgeInsets.only(left: 10,right: 10,top: 90),
    child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.placeList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          child: ListTile(
            onTap: (){
              SearchTextFields.searchcontroller.text = state.placeList[index][PlacesSearchKey.description];
              state.selectLong = true;
              state.addressToGetLatLong();
              state.placeList.length = 0;
            },
            title: Text(state.placeList[index][PlacesSearchKey.description]),
          ),
        );
      },
    ),
  );
}
