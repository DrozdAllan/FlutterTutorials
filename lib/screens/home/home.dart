import 'package:flutter/material.dart';
import 'package:mynewapp/services/notification_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = '/';
  static const _url = 'https://drozdallanportfolio.web.app/';

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter Tutorials'),
        actions: [
          IconButton(
            onPressed: () async {
              await canLaunch(_url)
                  ? await launch(_url)
                  : throw 'Could not launch $_url';
            },
            icon: Icon(Icons.help),
            tooltip: 'About',
          )
        ],
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
            title: Text('UserApiTest'),
            onTap: () {
              Navigator.pushNamed(context, '/userApiTest');
            },
          ),
          ListTile(
            title: Text('Hive database'),
            onTap: () {
              Navigator.pushNamed(context, '/hive');
            },
          ),
          ListTile(
            title: Text('Flutter_form_builder package'),
            onTap: () {
              Navigator.pushNamed(context, '/formBuilderTuto');
            },
          ),
          ListTile(
            title: Text('Riverpod state'),
            onTap: () {
              Navigator.pushNamed(context, '/riverpod');
            },
          ),
          ListTile(
            title: Text('FlutterFire'),
            onTap: () {
              Navigator.pushNamed(context, '/flutterFire');
            },
          ),
        ],
      ),
    );
  }
}
