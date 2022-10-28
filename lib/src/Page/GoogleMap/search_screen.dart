// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_place/google_place.dart';
// import 'package:googlemap_demo/src/Page/GoogleMap/map_screen.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final startSearchFieldController =  TextEditingController();
//   ////final enadSearchFieldController = TextEditingController();
//
//  DetailsResult? startPosition;
//  DetailsResult? endPosition;
//
//  late FocusNode startFocusNode;
// /// late FocusNode endFocusNode;
//
//   List<AutocompletePrediction> predictions = [];
//   Timer? _debounce;
//   late GooglePlace googlePlace;
//
//   @override
//   void initState(){
//     super.initState();
//     String apiKey = 'AIzaSyBoz3j8mkWt64YQYLNEEln3Eg0mUMRJ-2I';
//     googlePlace = GooglePlace(apiKey);
//
//     startFocusNode = FocusNode();
//    /// endFocusNode = FocusNode();
//   }
//
//   void dispose(){
//     super.dispose();
//     startFocusNode.dispose();
//     ///endFocusNode.dispose();
//   }
//
//   void autoCompleteSearch(String value)async{
//     var result = await googlePlace.autocomplete.get(value);
//     print(result);
//     if (result != null && result.predictions != null && mounted)
//     {
//       print(result.predictions!.first.description);
//       setState(() {
//         predictions = result.predictions!;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: startSearchFieldController,
//               style: const TextStyle(fontSize: 24),
//               focusNode: startFocusNode,
//               decoration: InputDecoration(
//                 prefix:const Icon(
//                   Icons.search,
//                   size: 24,
//                   color: Colors.black,
//                 ) ,
//                   hintText: 'Search Location',
//                   hintStyle: const TextStyle(fontSize: 20),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: InputBorder.none,
//                 suffixIcon: startSearchFieldController.text.isNotEmpty
//                   ?IconButton(onPressed: (){
//                     setState(() {
//                       predictions = [];
//                       startSearchFieldController.clear();
//                     });
//                   }, icon:const Icon(Icons.clear_rounded),
//                 ): null
//               ),
//               onChanged:(value){
//                 if(_debounce?.isActive ?? false)_debounce!.cancel();
//                 _debounce = Timer(const Duration(microseconds: 1000),(){
//                   if(value.isNotEmpty){
//                     autoCompleteSearch(value);
//                   }else{
//                     setState(() {
//                       predictions = [];
//                       startPosition = null;
//                     });
//                   }
//                 });
//               }
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               //focusNode: endFocusNode,
//               enabled: startSearchFieldController.text.isNotEmpty && startPosition != null,
//               onChanged:(value){
//                 if(_debounce?.isActive ?? false)_debounce!.cancel();
//                 _debounce = Timer(const Duration(microseconds: 1000),(){
//                   if(value.isNotEmpty){
//                     autoCompleteSearch(value);
//                   }else{
//                     setState(() {
//                       predictions = [];
//                       endPosition = null;
//                     });
//                   }
//                 });
//               } ,
//               style: const TextStyle(fontSize: 24),
//               ///controller: enadSearchFieldController,
//               decoration: InputDecoration(
//                   hintText: 'End Point',
//                   hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: InputBorder.none,
//                   suffixIcon:  enadSearchFieldController.text.isNotEmpty
//                       ?IconButton(onPressed: (){
//                            setState(() {
//                             predictions = [];
//                             enadSearchFieldController.clear();
//                        });
//                       }, icon:const Icon(Icons.clear_rounded),
//                  ): null
//               ),
//               ),
//             ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: predictions.length,
//                 itemBuilder: (context, index){
//                   return ListTile(
//                     leading: const CircleAvatar(
//                       child: Icon(
//                         Icons.pin_drop
//                       ),
//                     ),
//                     title: (
//                         Text(predictions[index].description.toString())
//                     ),
//                     onTap: () async {
//                       final placeId = predictions[index].placeId!;
//                       final details = await googlePlace.details.get(placeId);
//                       if(details != null && details.result != null && mounted)
//                         {
//                           if(startFocusNode.hasFocus){
//                             setState(() {
//                               startPosition = details.result;
//                               startSearchFieldController.text = details.result!.name!;
//                               predictions = [];
//                             });
//                           }
//                           // else{
//                           //   setState(() {
//                           //     endPosition = details.result;
//                           //     enadSearchFieldController.text = details.result!.name!;
//                           //     predictions = [];
//                           //   });
//                           // }
//                           if(startPosition != null /*&& endPosition != null*/){
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context)=> MapScreen(/*startPosition: startPosition*/ /*endPosition: endPosition*/))
//                             );
//                           }
//                         }
//                     },
//                   );
//                 }
//             ),
//           ],
//         ),
//       )
//     );
//   }
// }
