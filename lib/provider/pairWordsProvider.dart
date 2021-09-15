import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/database/database.dart';

// CHOOSE THE ONE YOU NEED

// Simple provider, no capability to change its value (nothing more than int++ or int-- and delete)
final pairWordsProvider = Provider<Set<String>>((ref) {
  return ref.read(databaseProvider).getWordPairsList();
});

// Complex provider, needs a stateNotifierProvider that returns a stateNotifier class
final pairWordsNotifierProvider =
    StateNotifierProvider.autoDispose<PairWordsNotifier, Set<String>>((ref) {
  return PairWordsNotifier();
});

class PairWordsNotifier extends StateNotifier<Set<String>> {
  PairWordsNotifier() : super({'bobo', 'zinzin', 'caca'});

  void removePair(String pairToRemove) {
    state = state.where((pairWords) => pairWords != pairToRemove).toSet();
    print(state);
  }
}
