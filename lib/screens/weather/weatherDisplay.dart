import 'package:flutter/material.dart';
import 'package:mynewapp/models/userModel.dart';

class WeatherDisplay extends StatelessWidget {
  final result;

  WeatherDisplay({Key? key, required this.result}) : super(key: key);

  static const routeName = '/weatherDisplay';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(result.title),
    );
  }
}
