import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/provider/pairWordProvider.dart';

// CONSUME A PROVIDER AND NOTIFY CHANGES IN A STATELESS WIDGET

class Riverpod extends ConsumerWidget {
  const Riverpod({Key? key}) : super(key: key);

  static const routeName = '/riverpod';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pairWordController);
    final notifier = ref.read(pairWordController.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('What is Riverpod ?'),
      ),
      extendBody: true,
      body: Column(
        children: [
          _presentationText(),
          Expanded(
            child: ListView.builder(
                itemCount: controller.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: ListTile(
                        title: Text(controller.elementAt(index)),
                        trailing: Icon(Icons.delete),
                        onTap: () {
                          notifier.removePair(controller.elementAt(index));
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _presentationText() {
    return Column(
      children: [
        Text(
          'Flutter_riverpod is a state manager that wraps flutter\'s InheritedWidget and provide a solution to the pairWords problem : you can create a state, make complex functions on it, and place a notifier to rebuild the widget everytime the state changes. The state will persist if you don\' restart the app',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ],
    );
  }
}
