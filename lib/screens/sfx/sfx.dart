import 'package:flutter/material.dart';
import 'package:mynewapp/screens/sfx/fluid_navbar.dart';

class Sfx extends StatefulWidget {
  const Sfx({Key? key}) : super(key: key);

  static const routeName = "/sfx";

  @override
  _SfxState createState() => _SfxState();
}

class _SfxState extends State<Sfx> {
  late Widget _child;

  @override
  void initState() {
    super.initState();
    _child = HomeContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/bubble'),
              icon: Icon(Icons.bubble_chart))
        ],
      ),
      body: _child,
      bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomeContent();
          break;
        case 1:
          _child = AccountContent();
          break;
        case 2:
          _child = GridContent();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AccountContent extends StatelessWidget {
  const AccountContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GridContent extends StatelessWidget {
  const GridContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
