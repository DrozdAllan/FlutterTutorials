import 'package:flutter/material.dart';

class Animations extends StatefulWidget {
  const Animations({Key? key}) : super(key: key);

  static const routeName = "/animations";

  @override
  _AnimationsState createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> {
  var align = Alignment.centerLeft;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations Tutorials"),
      ),
      body: Column(
        children: [
          Text('Implicit animations : Animated'),
          AnimatedAlign(
            child: const Icon(Icons.access_alarm),
            duration: const Duration(seconds: 3),
            alignment: align,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                align = Alignment.centerRight;
              });
            },
            child: Text("Click me"),
          ),
        ],
      ),
    );
  }
}
