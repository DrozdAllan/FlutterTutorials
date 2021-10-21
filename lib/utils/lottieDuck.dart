import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class LottieDuck extends StatefulWidget {
  const LottieDuck({Key? key}) : super(key: key);
  @override
  _LottieDuckState createState() => _LottieDuckState();
}

class _LottieDuckState extends State<LottieDuck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast().init(context);
    _controller = AnimationController(
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        // do something here to get a progress of each frame of the animation
      });
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // do something here after the animation has finished
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.reset();
        _controller.forward();
        fToast.showToast(
            child: duckToast,
            toastDuration: Duration(seconds: 1),
            gravity: ToastGravity.TOP);
      },
      child: Lottie.asset(
        'assets/duck.json',
        height: 100,
        width: 100,
        controller: _controller,
        onLoaded: (composition) {
          // Configure the AnimationController with the duration of the Lottie file and start the animation with forward()
          _controller
            ..duration = composition.duration
            ..forward();
        },
      ),
    );
  }
}

Widget duckToast = PhysicalModel(
  color: Colors.black,
  elevation: 8.0,
//   borderRadius: BorderRadius.circular(45),
  shape: BoxShape.circle,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.yellow,
    ),
    child: Text("Coin !"),
  ),
);
