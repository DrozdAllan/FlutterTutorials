import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/database/wordBox.dart';

// CHOOSE THE ONE YOU NEED

// Simple provider, no capability to create state (nothing more than int++ or int-- and delete)
final pairWordsProvider = Provider<Set<String>>((ref) {
  return ref.read(databaseProvider).getWordPairsList();
});

// Complex provider, needs a stateNotifierProvider that returns a stateNotifier class
final pairWordsController =
    StateNotifierProvider<PairWordsNotifier, Set<String>>(
        (ref) => PairWordsNotifier());

class PairWordsNotifier extends StateNotifier<Set<String>> {
  PairWordsNotifier() : super({'bobo', 'zinzin', 'caca'});

  void removePair(String pairToRemove) {
    state = state.where((pairWords) => pairWords != pairToRemove).toSet();
    print(state);
  }
}
