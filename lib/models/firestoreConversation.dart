import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreConversation {
  final String created;

  FirestoreConversation({required this.created});

  factory FirestoreConversation.fromMap(Map<String, dynamic>? object) =>
      FirestoreConversation(created: object?['created']);

  factory FirestoreConversation.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    Map data = documentSnapshot.data() as Map<String, dynamic>;
    return FirestoreConversation(created: data['created']);
  }
}
