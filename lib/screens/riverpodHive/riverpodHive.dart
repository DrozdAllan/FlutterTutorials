import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/provider/pairWordsProvider.dart';

// CONSUME A PROVIDER AND NOTIFY CHANGES IN A STATELESS WIDGET

class RiverpodHive extends ConsumerWidget {
  const RiverpodHive({Key? key}) : super(key: key);

  static const routeName = '/riverpodHive';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pairWordsController);
    final notifier = ref.read(pairWordsController.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('What is RiverpodHive ?'),
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
          'RiverpodHive is a mix of two powerful packages: flutter_riverpod is a state manager that wraps flutter\'s InheritedWidget and provide a solution to the pairWords problem : you can create a state, make complex functions on it, and place a notifier to rebuild the widget everytime the state changes',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
        Text(
          'We will create a state from a local NoSQL database, created with hive (https://blog.logrocket.com/handling-local-data-persistence-flutter-hive/)',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ],
    );
  }
}


// CONSUME A PROVIDER AND NOTIFY CHANGES IN A STATEFUL WIDGET

// class RiverpodHive extends ConsumerStatefulWidget {
//   const RiverpodHive({Key? key}) : super(key: key);

//   static const routeName = '/research';

//   @override
//   _RiverpodHiveState createState() => _RiverpodHiveState();
// }

// class _RiverpodHiveState extends ConsumerState<RiverpodHive> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = ref.watch(pairWordsNotifierProvider);
//     final notifier = ref.watch(pairWordsNotifierProvider.notifier);

//     return Scaffold(
//       body: ListView.builder(
//           itemCount: provider.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               child: ListTile(
//                   title: Text(provider.elementAt(index)),
//                   trailing: Icon(Icons.delete),
//                   onTap: () {
//                     notifier.removePair(provider.elementAt(index));
//                   }),
//             );
//           }),
//     );
//   }
// }
