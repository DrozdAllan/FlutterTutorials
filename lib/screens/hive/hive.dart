import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mynewapp/database/duckBox.dart';
import 'package:mynewapp/models/duck.dart';
import 'package:mynewapp/utils/lottieDuck.dart';

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
          box == null ? Container() : DuckList(box: box),
        ],
      ),
    );
  }

  _presentationText() {
    return Column(
      children: [
        Text(
          'Hive is a local NoSQL key-value database handler. These are the ducks from the hive database',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
        ),
      ],
    );
  }
}

class DuckList extends StatefulWidget {
  const DuckList({
    Key? key,
    required this.box,
  }) : super(key: key);

  final Box box;

  @override
  State<DuckList> createState() => _DuckListState();
}

class _DuckListState extends State<DuckList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: widget.box.listenable(),
        builder: (context, Box box, _) {
          // convert the duckBox to a list to make a ListView Builder
          List<dynamic> ducksList = box.values.toList();
          return ListView.builder(
            itemCount: ducksList.length,
            itemBuilder: (BuildContext context, int listIndex) {
              // get the duck from his index on the list to easily get the duck's properties (name, key...)
              final Duck duck = ducksList.elementAt(listIndex);
              return Dismissible(
                key: Key(duck.name),
                onDismissed: (direction) {
                  DuckBox.box?.delete(duck.key);
                  context.showSuccessBar(
                      content: Text('${duck.name} s\'en va !'));
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //           content: Text("${duck.name} supprimé")));
                },
                background: Container(
                  color: Colors.amber,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/duckDetails',
                        arguments: listIndex);
                  },
                  child: Card(
                    margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    elevation: 8,
                    child: Row(
                      children: [
                        Hero(
                          tag: "imageRecipe" + duck.name,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.wgoqatar.com/wp-content/uploads/2020/02/951871_highres-780x470.jpg',
                            //   imageBuilder: (context, imageProvider) => Container(
                            //     decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //         image: imageProvider,
                            //         fit: BoxFit.cover,
                            //         colorFilter: ColorFilter.mode(
                            //             Colors.lightGreen, BlendMode.colorBurn),
                            //       ),
                            //     ),
                            //   ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 5, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(duck.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              Text('Tap for details, Swipe to delete',
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 16))
                            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LottieDuck(),
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
              LottieDuck(),
            ],
          ),
        ],
      ),
    );
  }
}
