import 'package:flutter/material.dart';
import 'package:mynewapp/screens/animations/SineCurve.dart';

class Animations extends StatefulWidget {
  const Animations({Key? key}) : super(key: key);

  static const routeName = "/animations";

  @override
  _AnimationsState createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> with TickerProviderStateMixin {
  bool animationStatus = false;
  late AnimationController _controller;
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
    _animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations Tutorials"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Implicitly animated built-in widgets : AnimatedFoo \n',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'No AnimationController, no repeat, and only for one single child, don\'t need to use them in a stful w setState but also in Stream or Future to trigger the animation \n',
                  textAlign: TextAlign.center),
              Text('Here we have AnimatedAlign', textAlign: TextAlign.center),
              AnimatedAlign(
                child: const Icon(Icons.access_alarm),
                duration: const Duration(seconds: 3),
                alignment: animationStatus
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
              ),
              Text('Here we have AnimatedDefaultTextStyle',
                  textAlign: TextAlign.center),
              TextButton(
                onPressed: () {
                  setState(() {
                    animationStatus
                        ? animationStatus = false
                        : animationStatus = true;
                  });
                },
                child: AnimatedDefaultTextStyle(
                  child: Text("Click me"),
                  duration: Duration(seconds: 3),
                  style: TextStyle(
                      color: animationStatus ? Colors.blue : Colors.red),
                ),
              ),
              Text('Here we have AnimatedContainer',
                  textAlign: TextAlign.center),
              AnimatedContainer(
                duration: Duration(seconds: 3),
                color: animationStatus ? Colors.blue : Colors.red,
                width: animationStatus ? 35.0 : 60.0,
                height: animationStatus ? 60.0 : 35.0,
                // Built-in Curves at https://api.flutter.dev/flutter/animation/Curves-class.html
                // curve: Curves.elasticInOut,
                // But you can easily extends the Curve class and create your own : check SineCurve.dart
                curve: SineCurve(),
              ),
              Text(
                  'There is also AnimatedContainer, AnimatedAlign, AnimatedOpacity, AnimatedPadding, AnimatedRotation, AnimatedPhysicalModel, AnimatedPositioned, AnimatedPositionedDirectional, AnimatedSize, AnimatedTheme, AnimatedCrossFade and AnimatedSwitcher \n',
                  textAlign: TextAlign.center),
              Text(
                'Implicitly animated custom widgets : TweenAnimationBuilder \n',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('j\'ai mis un exemple mais c\'est de la merde',
                  textAlign: TextAlign.center),
              TweenAnimationBuilder(
                tween: ColorTween(begin: Colors.white, end: Colors.green),
                duration: Duration(seconds: 3),
                child: Image.asset(
                  'assets/icon.png',
                  width: 30,
                  height: 30,
                ),
                // if you dont modify that tween's values, its best to declare it as a Static Final variable
                builder: (_, Color? color, Widget? myChild) {
                  return ColorFiltered(
                    child: myChild,
                    colorFilter:
                        ColorFilter.mode(Colors.pink, BlendMode.modulate),
                  );
                },
              ),
              Text(
                'Explicitly animated built-in widgets : FooTransition \n',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'Need an AnimationController, can repeat, loop, pause etc \n',
                  textAlign: TextAlign.center),
              Text('Here we have RotationTransition \n',
                  textAlign: TextAlign.center),
              Container(
                color: Colors.black,
                child: Center(
                  child: RotationTransition(
                    turns: _controller,
                    child: Image.asset(
                      'assets/icon.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_controller.isAnimating) {
                    _controller.stop();
                    // _controller.reset();
                  } else {
                    // _controller.repeat();
                    // _controller.reverse();
                    _controller.forward();
                  }
                },
                child: Text('Play/Pause Rotation'),
              ),
              Text(
                  'There is also SizeTransition, FadeTransition, AlignTransition, ScaleTransition, SlideTransition, PositionedTransition, DecoratedBoxTransition, DefaultTextStyleTransition, RelativePositionedTransition and StatusTransitionWidget \n',
                  textAlign: TextAlign.center),
              Text(
                'Explicitly animated custom widgets : AnimatedBuilder & AnimatedWidget \n',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) => ClipPath(
                  clipper: const BeamClipper(),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 1.5,
                        colors: [
                          Colors.yellow,
                          Colors.transparent,
                        ],
                        stops: [0, _animation.value],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
