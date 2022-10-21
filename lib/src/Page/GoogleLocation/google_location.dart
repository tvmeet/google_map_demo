import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GoogleLocationNotifier>(context, listen: false).getSuggestion();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleLocationNotifier>(
      builder: (context, state, child){
        return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Google Location API'),
              ),
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
                     padding: const EdgeInsets.symmetric(vertical: 12),
                     child: Column(
                       children: [
                         TextFormField(
                           controller: SearchTextFields.searchcontroller,
                           decoration: const InputDecoration(
                               hintText: ' Search palaces with name'
                           ),
                         ),
                         Expanded(
                             child: ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: state.placeList.length,
                                 itemBuilder: (context, index){
                                   return const ListTile(
                                       // title: Stack
                                       // Text(
                                       // state.placeList.[index]),
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
}
