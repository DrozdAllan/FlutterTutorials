import 'package:flutter/material.dart';
import 'package:mynewapp/api/weatherApi.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

  static const routeName = '/weather';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [WeatherForm()],
    );
  }
}

class WeatherForm extends StatefulWidget {
  const WeatherForm({Key? key}) : super(key: key);

  @override
  _WeatherFormState createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
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
                  labelText: 'Entrez une ville',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
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
                fetchWeather(cityController.value.text);
                // if (formKey.currentState?.validate() == true) {

                // }
              },
              child: Text('Check Weather'),
            ),
          )
        ],
      ),
    );
  }
}
