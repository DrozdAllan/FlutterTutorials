import 'package:flutter/material.dart';
import 'package:mynewapp/models/firestoreUser.dart';
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
                    StreamBuilder<FirestoreUser>(
                      stream: DatabaseService().userStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Snapshot has error");
                        }
                        if (!snapshot.hasData) {
                          return Text("Snapshot has no data");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          FirestoreUser? firestoreUser = snapshot.data;
                          return Column(
                            children: [
                              Text("Welcome ${firestoreUser?.name} !"),
                              Text("You have ${firestoreUser?.ducks} ducks"),
                              //   ElevatedButton(
                              //       onPressed: () {
                              //         DatabaseService().addDuck(
                              //             firestoreUser.ducks,
                              //             firestoreUser!.ducks);
                              //       },
                              //       child: Text('add a duck')),
                            ],
                          );
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
