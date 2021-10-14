import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/src/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mynewapp/database/duckBox.dart';

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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            margin: EdgeInsets.fromLTRB(30, 30, 30, 400),
                            elevation: 15,
                            child: Column(children: [
                              Stack(
                                children: [
                                  Hero(
                                    tag: "imageRecipe" + duck.name,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://www.wgoqatar.com/wp-content/uploads/2020/02/951871_highres-780x470.jpg',
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 100,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    top: 100,
                                    right: 0,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 8),
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
                                              color: Colors.grey[500],
                                              fontSize: 16),
                                        ),
                                        Text(
                                          duck.isExtinct ? 'exctinct' : 'alive',
                                          style: TextStyle(
                                              color: Colors.grey[850],
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
