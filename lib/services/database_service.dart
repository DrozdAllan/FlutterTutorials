import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/models/firestoreConversation.dart';
import 'package:mynewapp/models/firestoreUser.dart';

class UserService {
// users collection ref, with a FirestoreUser class converter
  static final usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<FirestoreUser>(
        fromFirestore: (snapshot, _) => FirestoreUser.fromMap(snapshot.data()!),
        toFirestore: (FirestoreUser firestoreUser, _) => firestoreUser.toMap(),
      );

  static final firestoreUserProvider = StreamProvider.autoDispose((ref) {
    String? userID = FirebaseAuth.instance.currentUser?.uid;

    return usersRef.doc(userID).snapshots();
  });

  Future<void> saveNewUser(String uid, String username) async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    return await usersRef
        .doc(uid)
        .set(FirestoreUser(uid: uid, name: username, notificationToken: token));
  }

  Future<void> updateUserNotificationToken(String uid) async {
    String? token = await FirebaseMessaging.instance.getToken();

    return await usersRef.doc(uid).update({'notificationToken': token});
  }

  Future<void> addDuck(int? previousDucks, int duckNumber) async {
    String? userID = FirebaseAuth.instance.currentUser?.uid;

    int totalDucks = duckNumber;

    if (previousDucks != null) {
      totalDucks = duckNumber + previousDucks;
    }

    return await usersRef.doc(userID).update({'ducks': totalDucks});
  }

  static final usersProvider = FutureProvider((ref) async {
    // retrieve the uid of the current FirebaseAuth User
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    // get the firestore async document snapshot from his uid
    var currentUser =
        await usersRef.doc(userID).get().then((snapshot) => snapshot.data()!);
    // query all the users (all the documents in 'users' collection) except the one with the same name as the currentUser
    return await usersRef
        .where('name', isNotEqualTo: currentUser.name)
        .get()
        .then((snapshot) => snapshot.docs);
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

    return conversationCollection
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => FirestoreMessage.fromMap(e.data())));
  });

  static sendMessage(String peerUid, int messageType, String message) async {
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    String? conversationId = '';

    if (userID.hashCode <= peerUid.hashCode) {
      conversationId = '$userID-$peerUid';
    } else {
      conversationId = '$peerUid-$userID';
    }

    await FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        // A ref to the conversation collection instance with a converter to be type safe
        .withConverter<FirestoreMessage>(
            fromFirestore: (snapshot, _) =>
                FirestoreMessage.fromMap(snapshot.data()!),
            toFirestore: (FirestoreMessage firestoreMessage, _) =>
                firestoreMessage.toMap())
        .add(FirestoreMessage(
            type: messageType,
            from: userID,
            to: peerUid,
            data: message,
            timestamp: Timestamp.now()));
  }
}
