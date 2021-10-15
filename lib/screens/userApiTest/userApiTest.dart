import 'package:flutter/material.dart';
import 'package:mynewapp/api/userApi.dart';
import 'package:mynewapp/models/apiUser.dart';

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
            child: FutureBuilder<ApiUser?>(
              future: _client.getUser(id: '1'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (!snapshot.hasData) {
                  return Text("Document does not exist");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  ApiUser? userInfo = snapshot.data;
                  if (userInfo != null) {
                    Data userData = userInfo.data;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(userData.avatar),
                        SizedBox(height: 10.0),
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
          'UserApi is a simple api call with the package dio : an Api Class send the request and deserialize the json through a Model Class. The flutter widget below is a FutureBuilder that waits for the async api call to return data to build the widget',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/moviesTitle');
          },
          child: Text('Try Movies Title Api'),
        ),
      ],
    );
  }
}
