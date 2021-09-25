import 'package:flutter/material.dart';
import 'package:mynewapp/models/firebaseUser.dart';
import 'package:mynewapp/services/authentication_service.dart';
import 'package:mynewapp/services/database_service.dart';

class FlutterProfile extends StatefulWidget {
  const FlutterProfile({Key? key}) : super(key: key);
  @override
  State<FlutterProfile> createState() => _FlutterProfileState();
}

class _FlutterProfileState extends State<FlutterProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What is Flutter Fire ?'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
                'FlutterFire is the implementation of Firebase components in flutter app, here we will use the basic of Auth and Firestore'),
            Container(
              child: Container(
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text('Logout'),
                      onPressed: () {
                        AuthenticationService().logOut();
                      },
                    ),
                    FutureBuilder<FirebaseUser>(
                      future: DatabaseService().getUser(),
                      builder: (BuildContext context,
                          AsyncSnapshot<FirebaseUser> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.hasData) {
                          return Text("Document does not exist");
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          FirebaseUser? data = snapshot.data;
                          return Text("Full Name: $data");
                        }
                        return Text("loading");
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
