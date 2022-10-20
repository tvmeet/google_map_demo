import 'package:flutter/material.dart';
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
    super.initState();
      var state = Provider.of<GoogleLocationNotifier>(context,listen: false);
      state.initialiseHomeScreen();
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
              body: Padding(
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
                          ///itemCount:placesList.length,
                            itemBuilder: (context, index){
                              return const ListTile(
                                ////title: Text(placesList[index]['Description']),
                              );
                            })
                    )
                  ],
                ),
              ),
            ),
        );
      },
    );
  }
}
