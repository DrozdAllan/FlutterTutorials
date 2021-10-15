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
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter Tutorials'),
        actions: [
          Transform.rotate(
            angle: -12.0,
            child: IconButton(
                onPressed: () {
                  _dark = !_dark;
                  EasyDynamicTheme.of(context)
                      .changeTheme(dynamic: false, dark: _dark);
                },
                icon: _dark ? Icon(Icons.wb_sunny) : Icon(Icons.brightness_3)),
          ),
          // an built in switch to quickly toggle dark mode
          //   EasyDynamicThemeSwitch(),
          Transform.scale(
            scale: 2.0,
            child: SpinKitWave(
              color: Colors.white,
              size: 10.0,
            ),
          ),
          Transform.translate(
            offset: Offset(-5, -10),
            child: IconButton(
              onPressed: () async {
                await canLaunch(Home._url)
                    ? await launch(Home._url)
                    : throw 'Could not launch ${Home._url}';
              },
              icon: Icon(Icons.help),
              tooltip: 'About',
            ),
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
            title: Text('Shared preferences'),
            onTap: () {
              Navigator.pushNamed(context, '/sharedPref');
            },
          ),
          ListTile(
            title: Text('Camera Demo'),
            onTap: () {
              Navigator.pushNamed(context, '/cameraDemo');
            },
          ),
          ListTile(
            title: Text('Flutter_form_builder package'),
            onTap: () {
              Navigator.pushNamed(context, '/formBuilderTuto');
            },
          ),
          ListTile(
            title: Text('flutter_colorpicker package'),
            onTap: () {
              Navigator.pushNamed(context, '/colorPicker');
            },
          ),
          ListTile(
            title: Text('flash package'),
            onTap: () {
              Navigator.pushNamed(context, '/flashTuto');
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
