import 'package:flutter/material.dart';

var styleDropDown = const InputDecoration(
  // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)), borderSide: BorderSide(width: 4, color: Colors.black, style: BorderStyle.solid)),
  //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)), borderSide: BorderSide(width: 10, color: Colors.red)),
  contentPadding: EdgeInsets.only(left: 14, bottom: 10),
  //  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)), borderSide: BorderSide(width: 1, color: Colors.black)),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
    borderSide: BorderSide(color: Colors.black, width: 0.5),
  ),

  hintMaxLines: 1,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
    borderSide: BorderSide(color: Colors.black, width: 0.5),
  ),
);
