
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Style/colors.dart';


///ShowToast
showToast(BuildContext context, String msg, Toast toast, {Color? backGroundColor, Color? textColor}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toast,
      textColor: textColor ?? backGround,
      backgroundColor: backGroundColor ?? Colors.blue);
}
