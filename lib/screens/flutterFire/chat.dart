import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/models/firestoreUser.dart';
import 'package:mynewapp/services/database_service.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  static const routeName = "/chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with flutterFire'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('choose an user to chat with :'),
            UsersList(),
          ],
        ),
      ),
    );
  }
}

class UsersList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(DatabaseService.usersProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (value) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(value.elementAt(index).name),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chatScreen',
                      arguments: value.elementAt(index).uid,
                    );
                  },
                );
              },
            );
          },
        );
  }
}
