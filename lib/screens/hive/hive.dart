import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// CONSUME A PROVIDER AND NOTIFY CHANGES IN A STATELESS WIDGET

class HiveTuto extends StatelessWidget {
  const HiveTuto({Key? key}) : super(key: key);

  static const routeName = '/hive';

  @override
  Widget build(BuildContext context) {
// TODO import the database

    return Scaffold(
      appBar: AppBar(
        title: Text('What is Hive ?'),
      ),
      extendBody: true,
      body: Column(
        children: [
          _presentationText(),
          //   Expanded(
          //     child: ListView.builder(
          //         itemCount: controller.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Container(
          //             child: ListTile(
          //                 title: Text(controller.elementAt(index)),
          //                 trailing: Icon(Icons.delete),
          //                 onTap: () {
          //                   notifier.removePair(controller.elementAt(index));
          //                 }),
          //           );
          //         }),
          //   ),
        ],
      ),
    );
  }

  _presentationText() {
    return Column(
      children: [
        Text(
          'Hive is a local NoSQL key-value database handler. These are the ducks from the hive database',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ],
    );
  }
}
