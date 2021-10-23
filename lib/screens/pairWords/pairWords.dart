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

  @override
  void initState() {
    super.initState();
    _suggestions.addAll(generateWordPairs().take(40));
  }

  // the args are on the same widget/page, so you dont have to import them
//   if you need to import them :
//   final args =
//   ModalRoute.of(context)!.settings.arguments as (an object model);
  static var _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scrollbar(
// scrollbar style is defined in the themeData in style.dart
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Animated AppBar'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/fav', arguments: _saved);
                    },
                    icon: Icon(Icons.hearing_outlined)),
              ],
              floating: true,
              expandedHeight: 200,
              pinned: false,
              stretch: true,
              // onStretchTrigger: () {}, to trigger functions on stretch like refreshing a list content
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Hello les zinzins"),
                background: FadeInImage.assetNetwork(
                    fadeInCurve: Curves.bounceIn,
                    placeholder: 'assets/icon.png',
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/7/74/White_domesticated_duck%2C_stretching.jpg'),
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_saved.contains(_suggestions.elementAt(index))) {
                        _saved.remove(_suggestions.elementAt(index));
                      } else {
                        _saved.add(_suggestions.elementAt(index));
                      }
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      alignment: Alignment.center,
                      color: _saved.contains(_suggestions.elementAt(index))
                          ? Colors.teal[600]
                          : Colors.teal[200],
                      child: Text(
                        _suggestions.elementAt(index).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ),
                childCount: 40,
              ),
            ),
            // SliverFillRemaining(
            //   child: Center(
            //     child: Column(
            //       children: [
            //         Text('The value blabla'),
            //         SizedBox(),
            //         Text('zinzinzouzouz'),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverList(
            //     delegate: SliverChildListDelegate([
            //   for (var i = 1; i <= 10; i++)
            //     ListTile(
            //       leading: CircleAvatar(),
            //       title: Text(i.toString()),
            //     )
            // ]))
          ],
        ),
      ),
    );
  }
}
