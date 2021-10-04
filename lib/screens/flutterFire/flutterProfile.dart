import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/models/firestoreUser.dart';
import 'package:mynewapp/services/authentication_service.dart';
import 'package:mynewapp/services/database_service.dart';

class FlutterProfile extends StatelessWidget {
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
                    _logoutButton(),
                    RiverpodStream(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _logoutButton() {
    return ElevatedButton(
      child: Text('Logout'),
      onPressed: () {
        AuthenticationService().logOut();
      },
    );
  }
}

class RiverpodStream extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(UserService.firestoreUserProvider).when(
          data: (firestoreUser) {
            FirestoreUser user = firestoreUser.data()!;
            return Column(
              children: [
                Text('welcome ' + user.name),
                Text('you have ${user.ducks.toString()} ducks'),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    UserService().addDuck(user.ducks, 1);
                  },
                  child: Text('add 1 duck'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    child: Text('Go to Chat')),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error : $error'),
        );
  }
}
