import 'package:flutter/material.dart';


class customTextField extends StatelessWidget {
  var lableText;
  var hintText;


   customTextField({
    this.width,
     this.title,
     this.align,
     this.validator,
     this.controller,
     this.focusNode,
      this.onSave,
     this.submit,
      this.obSecure,
      this.textInputAction,
     this.textInputType,
      this.textCapitalization,
      this.prefixIcon,
     this.suffixIcon,
     this.iconButton,
    this.lableText,
     required this.hintText,

    Key? key, bool? obscureText}) : super(key: key);


  double? width;
  String? title;
  TextAlign? align;
  FormFieldValidator? validator;
  TextEditingController? controller;
  FocusNode? focusNode;
   FormFieldSetter? onSave;
   ValueChanged<String>? submit;
   bool? obSecure;
   TextInputAction? textInputAction;
   TextInputType? textInputType;
   TextCapitalization? textCapitalization;
   IconData? prefixIcon;
   IconData? suffixIcon;
   IconButton? iconButton;

   @override
  Widget build(BuildContext context) {

    return Container(
   width:width ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         /// Text(title, style: Theme.of(context).textTheme.bodyText2),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            //textAlign: align,
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            onSaved: onSave,
            onFieldSubmitted: submit,
            //obscureText: obSecure,
            textInputAction: textInputAction,
            keyboardType: textInputType,
           /// textCapitalization: textCapitalization,
            cursorColor: Theme.of(context).focusColor,
            style: const TextStyle(fontWeight: FontWeight.w400,  fontSize: 16),
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: lableText,
              hintText: hintText,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.blueAccent)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 5.0)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 5.0)),
            ),



          )
        ],
      ),
    );
  }
}

