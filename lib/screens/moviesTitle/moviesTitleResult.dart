import 'package:flutter/material.dart';

class MoviesTitleResult extends StatelessWidget {
  final result;

  MoviesTitleResult({Key? key, required this.result}) : super(key: key);

  static const routeName = '/moviesTitle/result';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(result.title),
    );
  }
}
