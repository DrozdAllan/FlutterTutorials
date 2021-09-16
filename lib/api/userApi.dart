import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mynewapp/models/userModel.dart';

class UserApi {
  final String _baseUrl = 'https://reqres.in/api';

  Future<User?> getUser({required String id}) async {
    try {
      final response = await Dio().get(_baseUrl + '/users/$id');

      if (response.statusCode == 200) {
        print('User Info: ${response.data}');
        return User.fromJson(response.data);
      }
    } on DioError catch (err) {
      print(err);
      throw ("err.response?.statusMessage ?? 'Something went wrong!'");
    } on SocketException catch (err) {
      print(err);
      throw ('Please check your connection.');
    }
  }
}
