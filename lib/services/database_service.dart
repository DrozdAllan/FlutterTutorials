import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/models/firestoreConversation.dart';
import 'package:mynewapp/models/firestoreUser.dart';

class UserService {
// the collection reference, firestore way of pointing to a noSQL directory
  static final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

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
        // translate the Map<String, dynamic>? to a FirestoreUser model
        .then((value) => FirestoreUser.fromMap(value.data()));
    // query all the users (all the documents in 'users' collection) except the one with the same name as the currentUser
    QuerySnapshot<Map<String, dynamic>> users = await userCollection
        .where('name', isNotEqualTo: currentUser.name)
        .get();
    // translate the List of document snapshots to an iterable of FirestoreUsers to create a list with listviewBuilder
    return users.docs.map((snapshot) => FirestoreUsers.fromSnapshot(snapshot));
  });
}

class ConversationService {
  static final CollectionReference<Map<String, dynamic>>
      conversationCollection =
      FirebaseFirestore.instance.collection("conversations");

  static final conversationProvider =
      StreamProvider.family((ref, String peerUid) {
    // retrieve the uid of the current FirebaseAuth User
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    String? conversationId = '';

    if (userID.hashCode <= peerUid.hashCode) {
      conversationId = '$userID-$peerUid';
    } else {
      conversationId = '$peerUid-$userID';
    }

    print(conversationId);
    return conversationCollection
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => FirestoreMessage.fromMap(e.data())));
  });

  static sendMessage(String peerUid, String message) async {
    print(peerUid + message);

    String? userID = FirebaseAuth.instance.currentUser?.uid;
    String? conversationId = '';

    if (userID.hashCode <= peerUid.hashCode) {
      conversationId = '$userID-$peerUid';
    } else {
      conversationId = '$peerUid-$userID';
    }

    print(conversationId);

    await FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        // A ref to the conversation collection instance with a converter to be type safe
        .withConverter<FirestoreMessage>(
            fromFirestore: (snapshot, _) =>
                FirestoreMessage.fromMap(snapshot.data()!),
            toFirestore: (FirestoreMessage, _) => FirestoreMessage.toMap())
        .add(FirestoreMessage(
            from: userID,
            to: peerUid,
            data: message,
            timestamp: Timestamp.now().toString()));
  }
}
