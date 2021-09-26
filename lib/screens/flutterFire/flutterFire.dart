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
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data;
        if (user == null) {
          return FlutterAuth();
        } else {
          return FlutterProfile();
        }
      },
    );
  }
}
