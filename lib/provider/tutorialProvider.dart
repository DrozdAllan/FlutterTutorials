import 'package:flutter_riverpod/flutter_riverpod.dart';

// RIVERPOD TUTORIAL

// simple Provider, only providing data elsewhere, no state persistence
final simpleProvider = Provider<String>((ref) {
  return 'simpleProvider';
});

// Future Provider, same as simple Provider but async
final futureProvider = FutureProvider.autoDispose<String>((ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 'futureProvider';
});

// Stream Provider, same as Future Provider
final streamProvider = StreamProvider.autoDispose<int>((ref) async* {
  int i = 0;
  while (i < 10) {
    await Future.delayed(Duration(seconds: 2));
    print(i);
    yield i++;
  }
});

// Complex provider, needs a StateNotifierProvider (aka a Controller) that returns a StateNotifier class
final myController = StateNotifierProvider.autoDispose<MyNotifier, Set<String>>(
    (ref) => MyNotifier());

class MyNotifier extends StateNotifier<Set<String>> {
  MyNotifier() : super(_pairWords);

  static Set<String> _pairWords = {
    'MarsupilamiCongelo',
    'IssouZinzin',
    'AnnieWonkie'
  };

  void removePair(String pairToRemove) {
    state = state.where((pairWords) => pairWords != pairToRemove).toSet();
    print(state);
  }
}
