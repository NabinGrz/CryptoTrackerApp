import 'package:flutter/material.dart';

double getDeviceHeight(BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;
  return deviceHeight;
}

double getDeviceWidth(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  return deviceWidth;
}
