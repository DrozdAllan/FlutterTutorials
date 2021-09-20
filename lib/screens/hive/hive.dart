import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
                        List<dynamic> ducksList = box.values.toList();
                        inspect(ducksList);
                        return ListView.builder(
                          itemCount: ducksList.length,
                          itemBuilder: (BuildContext context, int duckKey) {
                            return ListTile(
                              title: Text(ducksList.elementAt(duckKey).name),
                              subtitle: Text('key is ' +
                                  ducksList.elementAt(duckKey).key.toString() +
                                  ' and isExtinct is ' +
                                  ducksList
                                      .elementAt(duckKey)
                                      .isExtinct
                                      .toString()),
                            );
                          },
                        );
                      })),
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
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
