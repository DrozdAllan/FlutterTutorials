import 'package:flutter/material.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  static const routeName = "/maps";

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Tuto'),
      ),
      body: Container(
        child: Text('zinzin'),
      ),
    );
  }
}
