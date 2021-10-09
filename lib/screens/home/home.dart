import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:mynewapp/services/notification_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = '/';
  static const _url = 'https://drozdallanportfolio.web.app/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter Tutorials'),
        actions: [
          //   EasyDynamicThemeBtn(),
          EasyDynamicThemeSwitch(),
          SpinKitWave(
            color: Colors.white,
            size: 10.0,
          ),
          IconButton(
            onPressed: () async {
              await canLaunch(Home._url)
                  ? await launch(Home._url)
                  : throw 'Could not launch ${Home._url}';
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
