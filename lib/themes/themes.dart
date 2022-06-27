import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.lato().fontFamily,
    scaffoldBackgroundColor: const Color.fromARGB(247, 237, 245, 253),
    textTheme: const TextTheme(
        bodyText1: TextStyle(fontSize: 22),
        bodyText2: TextStyle(fontSize: 17)));
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.lato().fontFamily,
    scaffoldBackgroundColor: const Color.fromARGB(36, 37, 45, 255),
    textTheme: const TextTheme(
        bodyText1: TextStyle(fontSize: 22),
        bodyText2: TextStyle(fontSize: 17)));
