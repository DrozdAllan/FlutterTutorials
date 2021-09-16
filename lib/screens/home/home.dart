import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter Tutorials'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('PairWords'),
            onTap: () {
              Navigator.pushNamed(context, '/pairWords');
            },
          ),
          ListTile(
            title: Text('Riverpod state + Hive database'),
            onTap: () {
              Navigator.pushNamed(context, '/riverpodHive');
            },
          ),
          ListTile(
            title: Text('UserApiTest'),
            onTap: () {
              Navigator.pushNamed(context, '/userApiTest');
            },
          ),
          ListTile(
            title: Text('FlutterFire'),
            onTap: () {
              Navigator.pushNamed(context, '/pairWords');
            },
          ),
        ],
      ),
    );
  }
}
