// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget LocationCustomTextFieldBG(double top, double width, child) {
  return Container(
    height: 50,
    width: width,
    padding: EdgeInsets.only(left: 10, right: 0, top: top),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Color(0xffF5F5F5),
          offset: Offset(10.0, 10.0),
          blurRadius: 30.0,
          spreadRadius: 20.0,
        ),
      ],
    ),
    child: child,
  );
}