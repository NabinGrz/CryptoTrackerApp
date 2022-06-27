import 'package:flutter/material.dart';

double getDeviceHeight(BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;
  return deviceHeight;
}

double getDeviceWidth(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  return deviceWidth;
}

Color pinkColor = const Color.fromARGB(255, 228, 78, 254);
Color blueColor = const Color(0xff4e6cfe);
Color greenColor = const Color.fromARGB(255, 78, 254, 119);
Color orangeColor = const Color.fromARGB(255, 254, 143, 78);
Color yellowColor = const Color.fromARGB(255, 225, 254, 78);
Color redwColor = const Color.fromARGB(255, 254, 78, 78);
//BUTTON COLOR
Color buttonColor = const Color(0xff58caf0);
//TEXT COLOR
Color textColor1 = const Color(0XFF767c9c);
Color whiteTextColor = Colors.white;
