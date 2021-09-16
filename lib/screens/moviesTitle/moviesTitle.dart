import 'package:flutter/material.dart';
import 'package:mynewapp/api/moviesTitleApi.dart';

class MoviesTitle extends StatelessWidget {
  const MoviesTitle({Key? key}) : super(key: key);

  static const routeName = '/moviesTitle';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies Title Api'),
      ),
      body: Column(
        children: [_presentationText(), MoviesTitleForm()],
      ),
    );
  }

  Widget _presentationText() {
    return Text(
        'Movies Title Api will perform a more complex api call, the Model Class will be generated with build_runner usin json_annotation and json_serializable https://blog.logrocket.com/networking-flutter-using-dio/');
  }
}

class MoviesTitleForm extends StatefulWidget {
  const MoviesTitleForm({Key? key}) : super(key: key);

  @override
  _MoviesTitleFormState createState() => _MoviesTitleFormState();
}

class _MoviesTitleFormState extends State<MoviesTitleForm> {
  final formKey = GlobalKey<FormState>();
  final cityController = TextEditingController();

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText:
                      'Enter the number of random movies you want (1 to 5)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number between 1 and 5';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                fetchMoviesTitle(cityController.value.text);
                // if (formKey.currentState?.validate() == true) {

                // }
              },
              child: Text('Check MoviesTitle'),
            ),
          )
        ],
      ),
    );
  }
}
