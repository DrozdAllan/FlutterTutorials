import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  static const routeName = '/fav';
  final Set<WordPair> favs;

  const Favorites({Key? key, required this.favs}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    final tiles = widget.favs.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 18.0),
          ),
          trailing: Icon(
            Icons.bookmark_remove,
            color: Colors.red,
          ),
          onTap: () {
            print(pair);
            setState(() {
              widget.favs.remove(pair);
            });
          },
        );
      },
    );

    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        backgroundColor: Colors.red,
        color: Colors.yellow,
        strokeWidth: 5,
        displacement: 100,
        edgeOffset: 20,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: ListView(children: divided),
      ),
    );
  }
}

Future<void> _refresh() {
  return Future.delayed(
    Duration(seconds: 3),
  );
}
