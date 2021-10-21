import 'package:flutter/material.dart';

class DrawerDemo extends StatelessWidget {
  const DrawerDemo({Key? key}) : super(key: key);

  static const routeName = "/drawer";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(child: Text("zinzin")),
              ),
              ListTile(
                title: Text('zaza'),
              ),
              ListTile(
                title: Text('zouzou'),
              ),
              ListTile(
                title: Text('zozo'),
              ),
            ],
          ),
        ),
        // endDrawer: Drawer(), to show on the right side
        body: Container(
          child: InteractiveViewer(
            child: Image(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1542902093-d55926049754'),
              fit: BoxFit.cover,
            ),
            alignPanAxis: true,
            constrained: true,
            // scaleEnabled: false,
            boundaryMargin: EdgeInsets.all(6),
            // onInteractionStart: _handleInteraction,
            // transformationController: _controller,
          ),
        ),
      ),
    );
  }
}
