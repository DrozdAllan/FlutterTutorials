import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

const BodyTextSize = 16.0;
const LargeTextSize = 24.0;

// fonts are stored in assets/fonts and notified in pubspec.yaml
const Montserra = 'Montserrat';

final Color _mainColor = Colors.teal.shade800;

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
    brightness: Brightness.light,
  ),
//   primarySwatch: Colors.orange,
//   visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.emilysCandyTextTheme(),
//   scaffoldBackgroundColor: Colors.orange[100],
// inputDecorationTheme: ,
// iconTheme: ,
// sliderTheme: ,
// tabBarTheme: ,
// tooltipTheme: ,
// cardTheme: ,
// chipTheme: ,
//   TextTheme(
//     bodyText2: TextStyle(
//       fontFamily: Montserra,
//       fontWeight: FontWeight.w300,
//       fontSize: BodyTextSize,
//       color: _mainColor,
//     ),
//     headline6: TextStyle(
//       fontFamily: Montserra,
//       fontWeight: FontWeight.w300,
//       fontSize: LargeTextSize,
//       color: Colors.black,
//     ),
//     bodyText1: TextStyle(
//       fontFamily: Montserra,
//       fontWeight: FontWeight.w300,
//       fontSize: BodyTextSize,
//       color: _mainColor,
//     ),
//   ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      //   TargetPlatform.android: ZoomPageTransitionsBuilder(),
      defaultTargetPlatform: ZoomPageTransitionsBuilder(),
      // FadeUpwardsPageTransitionsBuilder - OpenUpwardsPageTransitionsBuilder - ZoomPageTransitionsBuilder - CupertinoPageTransitionsBuilder
    },
  ),
//   appBarTheme: AppBarTheme(
//     color: Colors.amber,
//     elevation: 0,
//     titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
//     toolbarTextStyle:
//         TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
//     toolbarHeight: 40.0,
//   ),
  scrollbarTheme: ScrollbarThemeData(
    isAlwaysShown: true,
    thickness: MaterialStateProperty.all(10.0),
    thumbColor: MaterialStateProperty.all(Colors.cyan),
    trackColor: MaterialStateProperty.all(Colors.red),
    crossAxisMargin: 15.0,
    radius: Radius.circular(10),
    minThumbLength: 10,
  ),
);

ThemeData myDarkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    // Background for Appbar, Card...
    surface: Colors.lightGreen,
    // Text and Icons on Appbar, Card...
    onSurface: Colors.red,
    // Background for ElevatedButton, TextButton, Loaders...
    primary: Colors.orange,
    // Text and Icons on ElevatedButton, TextButton, Background on FormBuilderOption
    onPrimary: Colors.pink,
    // I don't know yet
    primaryVariant: Colors.green,
    // Background for FloatingActionButton, effect when you can't scroll more
    secondary: Colors.pink,
    // I don't know yet
    secondaryVariant: Colors.pink,
    // I don't know yet
    onSecondary: Colors.green,
    // I don't know yet
    onBackground: Colors.green,
    // I don't know yet
    background: Colors.green,
    // I don't know yet
    error: Colors.yellow,
    // I don't know yet
    onError: Colors.blue,
  ),
//   visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontFamily: Montserra,
      fontWeight: FontWeight.w300,
      fontSize: BodyTextSize,
    ),
    headline6: TextStyle(
      fontFamily: Montserra,
      fontWeight: FontWeight.w300,
      fontSize: LargeTextSize,
    ),
  ),
//   appBarTheme: AppBarTheme(
//     color: Colors.red,
//     elevation: 0,
//     titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//     toolbarTextStyle:
//         TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//     toolbarHeight: 40.0,
//   ),
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
