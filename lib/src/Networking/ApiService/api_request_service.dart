
import 'package:flutter/material.dart';

import 'api_service.dart';

///dummy api call for reference
getUsers(BuildContext context)async{
  try {
    var result = await ApiService.request(context, 'url', RequestMethods.GET);
  }catch(e){
    print("Get Users Exceptions : $e");
  }
}
