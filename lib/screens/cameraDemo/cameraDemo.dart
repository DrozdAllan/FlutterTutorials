import 'package:flutter/material.dart';

class CameraDemo extends StatelessWidget {
  static const routeName = "/cameraDemo";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        heightFactor: 5.0,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/stuff');
                },
                child: Text('stuffDetector')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/emotion');
                },
                child: Text('emotionDetector')),
          ],
        ),
      ),
    );
  }
}
