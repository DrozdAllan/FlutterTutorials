import 'package:dio/dio.dart';
import 'package:mynewapp/models/userModel.dart';

fetchWeather(String cityName) {
  try {
    var response = Dio().get('https://jsonplaceholder.typicode.com/todos/1');
    print(response);
    // print(response.toString());
    // return WeatherModel.fromJson(response);
  } catch (e) {
    print(e);
  }
  throw ('error');
}
