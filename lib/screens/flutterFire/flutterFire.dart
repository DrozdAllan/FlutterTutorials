import 'package:flutter/material.dart';

class FlutterFire extends StatelessWidget {
  const FlutterFire({Key? key}) : super(key: key);

  static const routeName = '/flutterFire';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What is Flutter Fire ?'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
                'FlutterFire is the implementation of Firebase components in flutter app, here we will use the basic of Auth and Firestore'),
            Text('ZINZIN')
          ],
        ),
      ),
    );
  }
}
