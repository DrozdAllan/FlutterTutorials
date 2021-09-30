import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/models/firestoreConversation.dart';
import 'package:mynewapp/models/firestoreUser.dart';

class DatabaseService {
// the collection reference, firestore way of pointing to a noSQL directory
  static final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  static final CollectionReference<Map<String, dynamic>> messageCollection =
      FirebaseFirestore.instance.collection("messages");

  static final firestoreUserProvider = StreamProvider<FirestoreUser>((ref) {
    String? userID = FirebaseAuth.instance.currentUser?.uid;

    return userCollection
        .doc(userID)
        .snapshots()
        .map((snap) => FirestoreUser.fromMap(snap.data()));
  });

  Future<void> saveNewUser(String uid, String username) async {
    return await userCollection.doc(uid).set({'name': username});
  }

  Future<void> addDuck(int duckNumber) async {
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    return await userCollection.doc(userID).set({'ducks': duckNumber});
  }

  static final usersProvider = FutureProvider((ref) async {
    // retrieve the uid of the current FirebaseAuth User
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    // get the firestore async document snapshot from his uid
    var currentUser = await userCollection
        .doc(userID)
        .get()
        // translate the DocumentSnapshot<Map<String, dynamic>> to a FirestoreUser model
        .then((value) => FirestoreUser.fromSnapshot(value));
    // query all the users (all the documents in 'users' collection) except the one with the same name as the currentUser
    QuerySnapshot<Map<String, dynamic>> users = await userCollection
        .where('name', isNotEqualTo: currentUser.name)
        .get();
    // translate the List of document snapshots to an iterable of FirestoreUsers to create a list with listviewBuilder
    return users.docs.map((e) => FirestoreUsers.fromSnapshot(e));
  });

  static final conversationProvider =
      StreamProvider.family((ref, peerUid) async* {
    // retrieve the uid of the current FirebaseAuth User
    String? userID = FirebaseAuth.instance.currentUser?.uid;

    String? conversationId = '';

    if (userID.hashCode <= peerUid.hashCode) {
      conversationId = '$userID-$peerUid';
    } else {
      conversationId = '$peerUid-$userID';
    }

    // search if the conversation already exists
    messageCollection
        .doc('$conversationId')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        // retrieve conversation
        var conv = messageCollection.doc('$conversationId').get();
        print(conv);
        // return messageCollection.doc('$conversationId').snapshots();
      } else {
        print('Document doesn\'t exist on the database');
        // create conversation
        messageCollection
            .doc('$userID-$peerUid')
            .set({'created': Timestamp.now()});
        return messageCollection.doc('$userID-$peerUid').get();
      }
    });
  });
}
