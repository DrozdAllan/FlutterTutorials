import 'package:flutter/material.dart';
import 'package:mynewapp/screens/flutterFire/flutterAuth.dart';
import 'package:mynewapp/screens/flutterFire/flutterProfile.dart';
import 'package:mynewapp/services/authentication_service.dart';

class FlutterFire extends StatelessWidget {
  static const routeName = '/flutterFire';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthenticationService().authState,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data;
        if (user == null) {
          print("user is not logged in");
          return FlutterAuth();
        } else {
          print('user logged in');
          return FlutterProfile();
        }
      },
    );
  }
}
