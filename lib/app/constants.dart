import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const int NORMAL_SCROLL_ANIMATION_LENGTH_MS = 250;
const int SCROLL_SPEED = 130;

final List<Color> colors = [
  Colors.green,
  Colors.red,
  Colors.yellow,
  Colors.purple,
  Colors.blue,
  Colors.cyan,
  Colors.indigo,
  Colors.orange,
  Colors.amber,
  Colors.lime,
  Colors.pink,
  Colors.teal,
];

const InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
  focusColor: Color(0xFFF6A00C),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      // ignore: deprecated_member_use
      color: Color(0xFFF6A00C),
    ),
  ),
  hintStyle: TextStyle(
    color: Color(0xFF818991),
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  ),
);

final TextTheme kTextTheme = TextTheme(
  displayMedium: GoogleFonts.inter(
    color: Colors.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
  ),
  headlineMedium: TextStyle(
    fontSize: 12.0,
    color: Colors.grey[300],
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
  ),
  bodyLarge: TextStyle(
    color: Colors.grey[300],
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  ),
  bodyMedium: TextStyle(
    color: Colors.grey[300],
    letterSpacing: 1.0,
  ),
);

final kDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryColor: const Color(0xFF121212),
  iconTheme: const IconThemeData().copyWith(color: Colors.white),
  fontFamily: 'Montserrat',
  inputDecorationTheme: kInputDecorationTheme,
  textTheme: kTextTheme,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFF6A00C),
  ),
);
