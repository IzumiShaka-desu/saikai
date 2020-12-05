import 'dart:convert';

import 'package:flutter/material.dart';

import 'color_pallete.dart';

SnackBar createSnackbar(String _msg) => SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: ColorPallete.mainWhite,
      content: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 50,
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _msg,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
InputDecoration createInputDecoration(
        {@required String label, @required Icon prefixIcon}) =>
    InputDecoration(
      hintText: "insert your $label",
      fillColor: ColorPallete.deepGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      labelText: label,
      hintStyle: TextStyle(color: ColorPallete.mainWhite),
      prefixIcon: prefixIcon,
    );

List<String> parseJsonToListString(String json) {
  var result = <String>[];
  (jsonDecode(json) as List).forEach((element) {
    result.add(
      element.toString(),
    );
  });
  return result;
}

Radius circularRadius(double radius) => Radius.circular(radius);
