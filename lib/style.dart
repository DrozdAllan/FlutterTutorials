import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const BodyTextSize = 16.0;
const LargeTextSize = 24.0;

// fonts are stored in assets/fonts and notified in pubspec.yaml
const Montserra = 'Montserrat';

final Color _mainColor = Colors.teal.shade800;

ThemeData myTheme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      //   TargetPlatform.android: ZoomPageTransitionsBuilder(),
      defaultTargetPlatform: ZoomPageTransitionsBuilder(),
      // FadeUpwardsPageTransitionsBuilder - OpenUpwardsPageTransitionsBuilder - ZoomPageTransitionsBuilder - CupertinoPageTransitionsBuilder
    },
  ),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.cyan,
  appBarTheme: AppBarTheme(
    color: Colors.amber,
    elevation: 0,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
    toolbarTextStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
    toolbarHeight: 40.0,
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
    bodyText1: TextStyle(
      fontFamily: Montserra,
      fontWeight: FontWeight.w300,
      fontSize: BodyTextSize,
      color: _mainColor,
    ),
  ),
);

ThemeData myDarkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.cyan,
  appBarTheme: AppBarTheme(
    color: Colors.red,
    elevation: 0,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    toolbarTextStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    toolbarHeight: 40.0,
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
