import 'package:english_words/english_words.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// CHOOSE THE ONE YOU NEED

// Simple provider, no capability to create state (nothing more than int++ or int-- and delete)
final pairWordProvider = Provider<Iterable<WordPair>>((ref) {
  final pairWords = generateWordPairs().take(5);
  return pairWords;
});

// Complex provider, needs a stateNotifierProvider that returns a stateNotifier class
final pairWordController = StateNotifierProvider<PairWordNotifier, Set<String>>(
    (ref) => PairWordNotifier());

class PairWordNotifier extends StateNotifier<Set<String>> {
  PairWordNotifier() : super(_pairWords);

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
