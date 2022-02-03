import 'dart:math';

import 'package:flutter/material.dart';

class Sinewave extends StatefulWidget {
  const Sinewave({Key? key}) : super(key: key);

  static const routeName = '/sinewave';

  @override
  _SinewaveState createState() => _SinewaveState();
}

class _SinewaveState extends State<Sinewave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.black,
            ),
          ),
          Wave(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
          ),
        ],
      ),
    );
  }
}

class Wave extends StatefulWidget {
  final Size size;

  const Wave({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<Wave> createState() => _WaveState();
}

class _WaveState extends State<Wave> with SingleTickerProviderStateMixin {
  late List<Offset> _points;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: 20), upperBound: 2 * pi);
    _controller.repeat();
    _initPoints();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipPath(
          clipper: WaveClipper(_controller.value, _points),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue[200],
          ),
        );
      },
    );
  }

  void _initPoints() {
    _points =
        List.filled(widget.size.width.toInt(), Offset(0, widget.size.height));
  }
}

class WaveClipper extends CustomClipper<Path> {
  double controllerValue;
  List<Offset> points;

  WaveClipper(
    this.controllerValue,
    this.points,
  );

  @override
  getClip(Size size) {
    Path path = Path();

    _makeSinewave(size);
    path.addPolygon(points, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  void _makeSinewave(Size size) {
    final amplitude = size.height / 16;
    final yOffset = amplitude;

    for (int x = 0; x < size.width; x++) {
      double y = amplitude * sin(x / 35 + controllerValue) + yOffset;

      Offset newPoint = Offset(x.toDouble(), y);
      points[x] = newPoint;
    }
  }
}
