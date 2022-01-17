import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

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
            Container(child: RiveAnimation()),
          ]),
        ),
      ),
    );
  }
}

class RiveAnimation extends StatefulWidget {
  const RiveAnimation({Key? key}) : super(key: key);

  @override
  _RiveAnimationState createState() => _RiveAnimationState();
}

class _RiveAnimationState extends State<RiveAnimation> {
  // Controller for playback
  late rive.RiveAnimationController _controller;

  // Toggles between play and pause animation states
  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = rive.SimpleAnimation('Flying');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: rive.RiveAnimation.asset(
          'assets/rocketship.riv',
          controllers: [_controller],
          // Update the play state when the widget's initialized
          onInit: (_) => setState(() {}),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        tooltip: isPlaying ? 'Pause' : 'Play',
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
