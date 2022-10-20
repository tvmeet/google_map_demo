import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
showProgressThreeDots(BuildContext context) {
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const SpinKitThreeBounce(
          color: Colors.blue,
          size: 25,
        ),
      ));
}
