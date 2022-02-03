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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  bool showMessage = false;

  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    _selections = List.generate(3, (_) => false);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter Tutorials'),
        actions: [
          AnimatedCrossFade(
            firstChild: LightButtonIcon(),
            secondChild: DarkButtonIcon(),
            crossFadeState: Theme.of(context).brightness == Brightness.dark
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(seconds: 1),
            sizeCurve: Curves.bounceOut,
            layoutBuilder:
                (topChild, topChildKey, bottomChild, bottomChildKey) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: bottomChild,
                    key: bottomChildKey,
                    bottom: 0,
                    top: 0,
                  ),
                  Positioned(child: topChild, key: topChildKey),
                ],
              );
            },
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
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Flutter Tutorials',
                applicationVersion: '0.2.1',
                applicationIcon: Image.asset(
                  'assets/icon.png',
                  width: 25,
                  height: 25,
                ),
                applicationLegalese:
                    'This application is developed by Allan Drozd on Flutter 2.5.3',
                children: [
                  GestureDetector(
                    child: Text(
                      'Visit Allan Drozd Website',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
                    onTap: () async {
                      await canLaunch(Home._url)
                          ? await launch(Home._url)
                          : throw 'Could not launch ${Home._url}';
                    },
                  ),
                ],
              );
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: GridView.count(
        childAspectRatio: 3,
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 30.0,
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
            title: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.cyan),
                children: [
                  TextSpan(text: 'flutter_'),
                  TextSpan(
                      text: 'colorpicker',
                      style: TextStyle(color: Colors.green, fontSize: 24)),
                  TextSpan(text: ' package'),
                ],
              ),
            ),
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
          ListTile(
            title: Text('TabController & TabBar'),
            onTap: () {
              Navigator.pushNamed(context, '/tab');
            },
          ),
          ListTile(
            title: Text('Drawer Demo'),
            onTap: () {
              Navigator.pushNamed(context, '/drawer');
            },
          ),
          ListTile(
            title: Text('Geolocator Package'),
            onTap: () {
              Navigator.pushNamed(context, '/geolocator');
            },
          ),
          ListTile(
            title: Text('Slidable Demo'),
            onTap: () {
              Navigator.pushNamed(context, '/slidable');
            },
          ),
          ListTile(
            title: Text('Animations Demo'),
            onTap: () {
              Navigator.pushNamed(context, '/animations');
            },
          ),
          ListTile(
            title: Text('Google Maps'),
            onTap: () {
              Navigator.pushNamed(context, '/maps');
            },
          ),
          ListTile(
            title: Text('Overpowered Sfx'),
            onTap: () {
              Navigator.pushNamed(context, '/sfx');
            },
          ),
          ListTile(
            title: Text('Sinewave training'),
            onTap: () {
              Navigator.pushNamed(context, '/sinewave');
            },
          ),
          IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.arrow_menu, progress: _animationController),
            onPressed: () {
              setState(() {
                isPlaying = !isPlaying;
                isPlaying
                    ? _animationController.forward()
                    : _animationController.reverse();
              });
            },
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.yellow, BlendMode.hue),
            child: Placeholder(
                //   color: Colors.green,
                // fallbackHeight: 100,
                // fallbackWidth: 75,
                ),
          ),
          GestureDetector(
            child: Stack(
              // whether it runs out of bounds or get clipped
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 25,
                  left: 75,
                  child: Text('zinzin'),
                ),
                AnimatedPositioned(
                    right: showMessage ? 0 : 75,
                    top: 25,
                    child: Container(
                      color: Colors.blue,
                      child: const Center(child: Text('Tap me')),
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn),
              ],
            ),
            onTap: () {
              setState(() {
                showMessage = !showMessage;
              });
            },
          ),
          ToggleButtons(
            children: [
              Icon(Icons.baby_changing_station),
              Icon(Icons.kayaking),
              Icon(Icons.gamepad),
            ],
            isSelected: _selections,
            onPressed: (int index) {
              setState(() {
                _selections[index] = !_selections[index];
              });
            },
            color: Colors.green,
            selectedColor: Colors.red,
            fillColor: Colors.yellow,
            splashColor: Colors.purple,
            highlightColor: Colors.pink,
            selectedBorderColor: Colors.cyan,
            // renderBorder: false,
            borderRadius: BorderRadius.circular(30),
            borderWidth: 5,
            borderColor: Colors.orange,
          )
        ],
      ),
    );
  }
}

class DarkButtonIcon extends StatelessWidget {
  const DarkButtonIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        EasyDynamicTheme.of(context).changeTheme(dynamic: false, dark: true);
      },
      icon: Icon(
        Icons.brightness_3,
        // size: 14,
      ),
    );
  }
}

class LightButtonIcon extends StatelessWidget {
  const LightButtonIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        EasyDynamicTheme.of(context).changeTheme(dynamic: false, dark: false);
      },
      icon: Icon(
        Icons.wb_sunny,
        // size: 14,
      ),
    );
  }
}
