import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.lato().fontFamily,
    textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 22)));
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.lato().fontFamily,
    textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 22)));
