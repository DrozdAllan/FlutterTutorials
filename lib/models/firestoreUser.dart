import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthUser {
  final String uid;

  FirebaseAuthUser({required this.uid});

  factory FirebaseAuthUser.fromMap(Map<String, dynamic>? object) =>
      FirebaseAuthUser(
        uid: object?['uid'],
      );
}

class FirestoreUser {
  final String name;
  final int ducks;

  FirestoreUser({required this.name, required this.ducks});

  factory FirestoreUser.fromMap(Map<String, dynamic>? object) => FirestoreUser(
        name: object?['name'],
        ducks: object?['ducks'] ?? 0,
      );
}

class FirestoreUsers {
  final String uid;
  final String name;
  final int ducks;

  FirestoreUsers({required this.uid, required this.name, required this.ducks});

  factory FirestoreUsers.fromSnapshot(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return FirestoreUsers(
        uid: doc.id, name: data['name'], ducks: data['ducks'] ?? 0);
  }
}
