import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const BodyTextSize = 16.0;
const LargeTextSize = 24.0;

// fonts are stored in assets/fonts and notified in pubspec.yaml
const Montserra = 'Montserrat';

final Color _mainColor = Colors.teal.shade800;

ThemeData? myTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.cyan,
  appBarTheme: AppBarTheme(
    color: Colors.amber,
    elevation: 0,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
    toolbarTextStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
    toolbarHeight: 20.0,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontFamily: Montserra,
      fontWeight: FontWeight.w300,
      fontSize: BodyTextSize,
      color: _mainColor,
    ),
    headline6: TextStyle(
      fontFamily: Montserra,
      fontWeight: FontWeight.w300,
      fontSize: LargeTextSize,
      color: Colors.black,
    ),
  ),
);
