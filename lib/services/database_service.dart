import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynewapp/models/firestoreUser.dart';

class DatabaseService {
// the collection reference, firestore way of pointing to a noSQL directory
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveNewUser(String uid, String username) async {
    return await userCollection.doc(uid).set({'name': username});
  }

  Stream<FirestoreUser> userStream() {
    String? userID = FirebaseAuth.instance.currentUser?.uid;

    return userCollection
        .doc(userID)
        .snapshots()
        .map((snap) => FirestoreUser.fromMap(snap.data()));
  }
}
