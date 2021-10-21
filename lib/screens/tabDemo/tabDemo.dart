import 'package:flutter/material.dart';

class TabDemo extends StatelessWidget {
  const TabDemo({Key? key}) : super(key: key);

  static const routeName = "/tab";

  @override
  Widget build(BuildContext context) {
    bool _throwShotAway = false;

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.access_alarm_rounded))
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: "Cat",
              ),
              Tab(
                text: "Dog",
              ),
              Tab(
                text: "Rabbit",
              ),
            ]),
          ),
          body: TabBarView(children: [
            Container(
              alignment: Alignment.center,
              child: ListWheelScrollView(
                  diameterRatio: 0.5,
                  offAxisFraction: -0.5,
                  useMagnifier: true,
                  magnification: 1.5,
                  itemExtent: 42,
                  children: [
                    Container(
                      color: Colors.amber,
                      child: Center(child: Text("zinzin")),
                    ),
                    Container(
                      color: Colors.cyan,
                      child: Center(child: Text("zinzin")),
                    ),
                    Container(
                      color: Colors.grey,
                      child: Center(child: Text("zinzin")),
                    ),
                    Container(
                      color: Colors.purple,
                      child: Center(child: Text("zinzin")),
                    ),
                    Container(
                      color: Colors.pink,
                      child: Center(child: Text("zinzin")),
                    ),
                  ]),
            ),
            ShaderMask(
              shaderCallback: (bounds) => RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.0,
                      colors: [Colors.red, Colors.black],
                      tileMode: TileMode.mirror)
                  .createShader(bounds),
              child: Image(
                image: AssetImage('assets/splash.png'),
              ),
            ),
            ListView(children: [
              SwitchListTile(
                  title: Text('SwitchListTileWidget'),
                  value: true,
                  onChanged: (value) {}),
              CheckboxListTile(
                  title: Text('SwitchListTileWidget'),
                  value: _throwShotAway,
                  onChanged: (newValue) {}),
            ]),
          ]),
        ),
      ),
    );
  }
}
