import 'package:flutter/material.dart';
import 'package:mynewapp/api/userApi.dart';
import 'package:mynewapp/models/userModel.dart';

class UserApiTest extends StatefulWidget {
  static const routeName = '/userApiTest';

  @override
  _UserApiTestState createState() => _UserApiTestState();
}

class _UserApiTestState extends State<UserApiTest> {
  final UserApi _client = UserApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Api'),
      ),
      body: Column(
        children: [
          _presentationText(),
          Center(
            child: FutureBuilder<User?>(
              future: _client.getUser(id: '1'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? userInfo = snapshot.data;
                  if (userInfo != null) {
                    Data userData = userInfo.data;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(userData.avatar),
                        SizedBox(height: 8.0),
                        Text(
                          '${userInfo.data.firstName} ${userInfo.data.lastName}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          userData.email,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    );
                  }
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  _presentationText() {
    return Column(
      children: [
        Text(
          'UserApi is a simple api call with the package dio, it will later call my Movie Titles api https://blog.logrocket.com/networking-flutter-using-dio/ ',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ],
    );
  }
}
