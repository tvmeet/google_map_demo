
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.3039, 70.8022),
    zoom: 4,
  );

  final List<Marker> _marker =[];
  final List<Marker> _list =[
    const Marker(markerId: MarkerId('1'),
    infoWindow: InfoWindow(
      title: 'my Current Location'
    ),
    position:LatLng(22.3039, 70.8022)
    ),
    // const Marker(markerId: MarkerId('2'),
    //     infoWindow: InfoWindow(
    //         title: 'e-11 Sector'
    //     ),
    //     position:LatLng(35.3039, 75.8022)
    //
    // ),
    // const Marker(markerId: MarkerId('3'),
    //     infoWindow: InfoWindow(
    //         title: 'e-552 Sector'
    //     ),
    //     position:LatLng(21.3039, 71.8022)
    //
    // )
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

   Future<Position>getUserCurrentLocation() async {
        await Geolocator.requestPermission().then((value){
        }).onError((error, stackTrace) {
          print('error');
        });
        return await Geolocator.getCurrentPosition();
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);

          },
        )
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     GoogleMapController controller = await _controller.future;
      //     controller.animateCamera(CameraUpdate.newCameraPosition(
      //         const CameraPosition(
      //           target: LatLng(21.3039, 71.8022),
      //           zoom: 14
      //         )
      //     ));
      //   },
      //   child: const Icon(Icons.location_disabled_outlined),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print("${value.latitude} ${value.longitude}");
            _marker.add(
              Marker(markerId: const MarkerId('1'),
              position: LatLng(value.longitude, value.longitude),
                infoWindow: const InfoWindow(
                  title: 'My current Location'
                )
              ),
              );
            CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude));

            final GoogleMapController controller = await _controller.future;

            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {

            });
          },);
        },
        child: const Icon(Icons.location_history),
      ),
    );
  }
}
