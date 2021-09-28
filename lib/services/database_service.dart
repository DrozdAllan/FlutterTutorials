import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/models/firestoreUser.dart';

class DatabaseService {
// the collection reference, firestore way of pointing to a noSQL directory
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  static final firestoreUserProvider = StreamProvider<FirestoreUser>((ref) {
    String? userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .snapshots()
        .map((snap) => FirestoreUser.fromMap(snap.data()));
  });

  Future<void> saveNewUser(String uid, String username) async {
    return await userCollection.doc(uid).set({'name': username});
  }

  Future<void> addDuck(int duckNumber) async {
    String? userID = FirebaseAuth.instance.currentUser?.uid;
// TODO: .set() put or replace the value, you have to read the value, add the new int and set again.
// TODO: whats the point of StreamProvider over StreamBuilder ????????
    return await userCollection.doc(userID).set({'ducks': duckNumber});
  }
}
