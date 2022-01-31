import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/provider/tutorialProvider.dart';

class Riverpod extends StatelessWidget {
  const Riverpod({Key? key}) : super(key: key);

  static const routeName = '/riverpod';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What is Riverpod ?'),
      ),
      extendBody: true,
      body: Column(
        children: [
          _presentationText(),
          SimpleProviderWidget(),
          FutureProviderWidget(),
          StreamProviderWidget(),
          StateProviderWidget(),
          DataTabla(),
        ],
      ),
    );
  }

  _presentationText() {
    return Column(
      children: [
        Text(
          'Flutter_riverpod is a state manager that wraps flutter\'s InheritedWidget',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ],
    );
  }
}

class DataTabla extends StatelessWidget {
  const DataTabla({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: 0,
      sortAscending: true,
      columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Year'), numeric: true),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Dash')),
          DataCell(Text('2018')),
        ], selected: true),
        DataRow(cells: [
          DataCell(Text('Gopher'), showEditIcon: true),
          DataCell(Text('2009'), placeholder: true),
        ]),
      ],
    );
  }
}

class StateProviderWidget extends ConsumerWidget {
  // from the StateNotifierProvider(Controller) and the StateNotifier in tutorialProvider.dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(myController);
    final notifier = ref.read(myController.notifier);

    return Expanded(
      child: ListView.separated(
        itemCount: controller.length,
        itemBuilder: (BuildContext context, int index) => Container(
          child: ListTile(
            title: SelectableText(
              controller.elementAt(index),
              showCursor: true,
              cursorWidth: 5,
              cursorColor: Colors.green,
              cursorRadius: Radius.circular(5),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                notifier.removePair(controller.elementAt(index));
              },
            ),
          ),
        ),
        separatorBuilder: (context, index) => Divider(
          height: 50,
          thickness: 4,
          color: Colors.purple,
          indent: 20,
          endIndent: 20,
        ),
      ),
    );
  }
}

class StreamProviderWidget extends ConsumerWidget {
  // from the StreamProvider in tutorialProvider.dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(streamProvider).when(
          data: (counter) => Text(counter.toString()),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error : $error'),
        );
  }
}

class FutureProviderWidget extends ConsumerWidget {
  // from the FutureProvider in tutorialProvider.dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(futureProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (value) {
            return Text(value);
          },
        );
  }
}

class SimpleProviderWidget extends ConsumerWidget {
// from the simpleProvider in tutorialProvider.dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(ref.watch(simpleProvider));
  }
}
