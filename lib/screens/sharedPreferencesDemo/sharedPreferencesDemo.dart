import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDemo extends StatefulWidget {
  SharedPreferencesDemo({Key? key}) : super(key: key);
  static const routeName = '/sharedPref';

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    double rating = 0.5;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences Demo"),
      ),
      body: Center(
        child: Column(
          children: [
            Draggable<String>(
              // axis: Axis.vertical,
              // Data is the value this Draggable stores.
              data: 'green',
              child: SizedBox(
                height: 100,
                width: 100,
                child: ColoredBox(
                  color: Colors.cyan,
                  child: Text('cyan'),
                ),
              ),
              childWhenDragging: SizedBox(
                height: 100,
                width: 100,
                child: ColoredBox(
                  color: Colors.blue,
                  child: Text('blue'),
                ),
              ),
              feedback: SizedBox(
                height: 100,
                width: 100,
                child: ColoredBox(
                  color: Colors.green,
                  child: Text(
                    'green',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            FutureBuilder<int>(
                future: _counter,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
                          'This should persist across restarts.',
                        );
                      }
                  }
                }),
            DragTarget(
              builder: (context, candidateData, rejectedData) {
                return candidateData.length > 0
                    ? SizedBox(
                        height: 100,
                        width: 100,
                        child: ColoredBox(
                          color: Colors.orange,
                          child: Text('orange'),
                        ),
                      )
                    : SizedBox(
                        height: 100,
                        width: 100,
                        child: ColoredBox(
                          color: Colors.red,
                          child: Text('red'),
                        ),
                      );
              },
            ),
            Slider(
              value: rating,
              onChanged: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 4,
              label: "$rating",
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => customDialog(),
              barrierDismissible: false);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  customDialog() {
    return CupertinoAlertDialog(
      title: Text('Add 1 to the counter ?'),
      insetAnimationDuration: Duration(seconds: 1),
      insetAnimationCurve: Curves.bounceOut,
      content: Icon(Icons.ac_unit_rounded),
      actions: [
        CupertinoDialogAction(
          child: Text("no"),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text('yes'),
          isDefaultAction: true,
          onPressed: () {
            _incrementCounter();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
