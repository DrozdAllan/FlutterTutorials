import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mynewapp/database/duckBox.dart';
import 'package:mynewapp/style.dart';

class DuckDetails extends StatefulWidget {
  final int ducksListIndex;
  const DuckDetails({Key? key, required this.ducksListIndex}) : super(key: key);

  static const routeName = "/duckDetails";

  @override
  _DuckDetailsState createState() => _DuckDetailsState();
}

class _DuckDetailsState extends State<DuckDetails> {
  late PageController _controller;

  // import the database
  final box = DuckBox.box;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.ducksListIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('zinzin'),
      ),
      body: Container(
        child: box == null
            ? Container()
            : ValueListenableBuilder(
                valueListenable: box!.listenable(),
                builder: (context, Box box, _) {
                  // convert the duckBox to a list to make a ListView Builder
                  List<dynamic> ducksList = box.values.toList();
                  return PageView.builder(
                    controller: _controller,
                    itemCount: ducksList.length,
                    itemBuilder: (BuildContext context, int listIndex) {
                      // get the duck from his index on the list to easily get the duck's properties (name, key...)
                      final duck = ducksList.elementAt(listIndex);
                      return Container(
                        child:
                            // AspectRatio(
                            //   aspectRatio: MediaQuery.of(context).orientation ==
                            //           Orientation.portrait
                            //       ? 6 / 7
                            //       : 17 / 7.5,
                            FractionallySizedBox(
                          heightFactor: 1,
                          child: Card(
                            margin: EdgeInsets.all(12),
                            elevation: 15,
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.black87,
                                  child: Column(
                                    children: [
                                      Hero(
                                        tag: "imageRecipe" + duck.name,
                                        child: ClipPath(
                                          clipper: MyClipper(),
                                          child: CachedNetworkImage(
                                            height: 275,
                                            imageUrl:
                                                'https://www.wgoqatar.com/wp-content/uploads/2020/02/951871_highres-780x470.jpg',
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            child: Text(duck.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Status of this species : ',
                                                style: TextStyle(
                                                    color: Colors.grey[300],
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                duck.isExtinct
                                                    ? 'exctinct'
                                                    : 'alive',
                                                style: TextStyle(
                                                    color: Colors.grey[100],
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 250,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.red,
                                  ),
                                ),
                                Positioned(
                                  top: 250,
                                  right: 0,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
