// import 'package:english_words/english_words.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

class Database {
  Set<String> _wordPairsList = {'bobo', 'zinzin', 'caca'};

  Set<String> getWordPairsList() {
    return _wordPairsList;
  }
}
