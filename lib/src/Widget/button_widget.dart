// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonWidgets extends StatefulWidget {
   ButtonWidgets({Key? key,
    required this.onTap,
    this.borderRadius,
    this.buttonColor,
    required this.buttonText,
    this.textColor
  }) : super(key: key);

  VoidCallback onTap;
  Color? buttonColor;
  double? borderRadius;
  Color? textColor;
  String buttonText;

  @override
  State<ButtonWidgets> createState() => _ButtonWidgetsState();
}

class _ButtonWidgetsState extends State<ButtonWidgets> {
   Color c1 = Colors.blueAccent;

   Color c2 = Colors.cyan;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 1.0],
          colors: [
            c1,
            c2,
          ],
        ),
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            ///padding: const EdgeInsets.all(20),
            width: 400,
            height: 50,
            child: Center(
              child: Text(
                widget.buttonText.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold ,
                  fontSize: 20,
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
