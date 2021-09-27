import 'package:english_words/english_words.dart';

import 'package:flutter/material.dart';

class PairWords extends StatefulWidget {
  const PairWords({Key? key}) : super(key: key);

  static const routeName = '/pairWords';

  @override
  _PairWordsState createState() => _PairWordsState();
}

class _PairWordsState extends State<PairWords> {
  final _suggestions = <WordPair>[];

  // the args are on the same widget/page, so you dont have to import them
//   if you need to import them :
//   final args =
//   ModalRoute.of(context)!.settings.arguments as (an object model);
  static var _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What is PairWords ?'),
      ),
      extendBody: true,
      body: Column(
        children: [
          _presentationText(),
          _buildSuggestions(),
        ],
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.bookmark_added : Icons.bookmark_add,
        color: alreadySaved ? Colors.green : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return Expanded(
      child: ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(9));
        }
        return _buildRow(_suggestions[index]);
      }),
    );
  }

  _presentationText() {
    return Column(
      children: [
        Text(
          'PairWords is a widget that generates a random/infinite List of pairWords with the package english_words. It saves the favored ones in a Set<WordPair> and passes it as an argument to the Favorites screen',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/fav', arguments: _saved);
          },
          child: Text('Go to favorites'),
        ),
      ],
    );
  }
}
