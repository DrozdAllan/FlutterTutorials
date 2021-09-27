import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

class StateProviderWidget extends ConsumerWidget {
  // from the StateNotifierProvider(Controller) and the StateNotifier in tutorialProvider.dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(myController);
    final notifier = ref.read(myController.notifier);

    return Expanded(
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
    );
  }
}

class StreamProviderWidget extends ConsumerWidget {
  // from the StreamProvider in tutorialProvider.dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<int> counter = ref.watch(streamProvider);
    return counter.when(
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
