import 'dart:io';
import 'package:flutter/material.dart';

import '../../Constant/app_strings.dart';
import '../../Style/text_style.dart';


Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AlertAppExitStrings.title,style: TextStyleTheme.customTextStyle(Colors.black, 16, FontWeight.w500,0),),
                const SizedBox(height: 22),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text(AlertAppExitStrings.yes),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(AlertAppExitStrings.no, style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}