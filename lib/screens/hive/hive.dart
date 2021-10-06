import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mynewapp/database/duckBox.dart';
import 'package:mynewapp/models/duck.dart';
import 'dart:developer';

class HiveTuto extends StatelessWidget {
  const HiveTuto({Key? key}) : super(key: key);

  static const routeName = '/hive';

  @override
  Widget build(BuildContext context) {
// import the database
    var box = DuckBox.box;

    return Scaffold(
      appBar: AppBar(
        title: Text('What is Hive ?'),
      ),
      extendBody: true,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _presentationText(),
          AddDuckForm(),
          box == null
              ? Container()
              : Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box box, _) {
                      // convert the duckBox to a list to make a ListView Builder
                      List<dynamic> ducksList = box.values.toList();
                      inspect(ducksList);
                      return ListView.builder(
                        itemCount: ducksList.length,
                        itemBuilder: (BuildContext context, int listIndex) {
                          // get the duck from his index on the list to easily get the duck's properties (name, key...)
                          final duck = ducksList.elementAt(listIndex);
                          return Dismissible(
                            key: Key(duck.name),
                            onDismissed: (direction) {
                              DuckBox.box?.delete(duck.key);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("${duck.name} supprimé")));
                            },
                            background: Container(
                              color: Colors.amber,
                            ),
                            child: Card(
                              margin: EdgeInsets.all(8),
                              elevation: 8,
                              child: Row(
                                children: [
                                  Hero(
                                    tag: "imageRecipe" + duck.name,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://www.wgoqatar.com/wp-content/uploads/2020/02/951871_highres-780x470.jpg',
                                      //   imageBuilder: (context, imageProvider) =>
                                      //       Container(
                                      //     decoration: BoxDecoration(
                                      //       image: DecorationImage(
                                      //         image: imageProvider,
                                      //         fit: BoxFit.cover,
                                      //         colorFilter: ColorFilter.mode(
                                      //             Colors.red,
                                      //             BlendMode.colorBurn),
                                      //       ),
                                      //     ),
                                      //   ),
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(duck.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ),
                                        Text('Tap for details, Swipe to delete',
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 16))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
          // the simple way
          //   Lottie.asset('assets/duck.json',
          //       width: 100, height: 100, fit: BoxFit.fill),
          // or the stateful widget with AnimationController
          LottieDuck(),
        ],
      ),
    );
  }

  _presentationText() {
    return Column(
      children: [
        Text(
          'Hive is a local NoSQL key-value database handler. These are the ducks from the hive database',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ],
    );
  }
}

class LottieDuck extends StatefulWidget {
  const LottieDuck({Key? key}) : super(key: key);

  @override
  _LottieDuckState createState() => _LottieDuckState();
}

class _LottieDuckState extends State<LottieDuck> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..value = 0.1
      ..addListener(() {
        setState(() {
          // Rebuild the widget at each frame to update the "progress" label.
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/duck.json',
      controller: _controller,
      onLoaded: (composition) {
        // Configure the AnimationController with the duration of the
        // Lottie file and start the animation.
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}

class AddDuckForm extends StatefulWidget {
  const AddDuckForm({Key? key}) : super(key: key);

  @override
  State<AddDuckForm> createState() => _AddDuckFormState();
}

class _AddDuckFormState extends State<AddDuckForm> {
  final _formKey = GlobalKey<FormState>();
  final duckController = TextEditingController();

  @override
  void dispose() {
    duckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: duckController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text('Enter duck name'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                DuckBox.box?.add(Duck(duckController.value.text, true));

                duckController.clear();

                FocusScope.of(context).unfocus();
              }
            },
            child: const Text('Add new duck'),
          ),
        ],
      ),
    );
  }
}
