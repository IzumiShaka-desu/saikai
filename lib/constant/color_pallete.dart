import 'package:flutter/material.dart';

abstract class ColorPallete{
  //main color grey , used for carousell at homepage
  static Color mainGrey = Color.fromRGBO(196,196,196,1);
  
  //main color grey , used for carousell at homepage
  static Color deepGrey = Colors.grey[400];
  //main color blue , used  widgets with blue background
  //  static Color mainBlue = Color.fromRGBO(41,98,255,1);
  static Color mainBlue = Color.fromRGBO(202, 241, 244,1);
  //main color orange ,  used for background of badge count
  static Color mainOrange = Color.fromRGBO(255,94,32,1);
  //main color white ,  used for widget with white backgcolor
  static Color mainWhite = Color.fromRGBO(255,255,255,1);
  //main grey text color , used for text at content
  static Color textGrey = Color.fromRGBO(130,130,130,1);
  //secondary grey text color , used for bottom navbat label
  static Color textGrey2 = Color.fromRGBO(208,208,208,1);
  //third grey text xolor ,secondary text content
  static Color textGrey3 = Color.fromRGBO(189,189,189,1);
  //main black text color ,  used for text on content
  static Color textBlack = Color.fromRGBO(51,51,51,1);
  //main white text color , used for text on content
  static Color textWhite = Color.fromRGBO(255,255,255,1);
}