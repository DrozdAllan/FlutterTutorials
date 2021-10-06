import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMessage {
  // type: 0 = text, 1 = image
  final int type;
  final String? from;
  final String to;
  final String data;
  final Timestamp timestamp;

  FirestoreMessage(
      {required this.type,
      required this.from,
      required this.to,
      required this.data,
      required this.timestamp});

  factory FirestoreMessage.fromMap(Map<String, dynamic> document) =>
      FirestoreMessage(
          type: document['type'],
          from: document['from'],
          to: document['to'],
          data: document['data'],
          timestamp: document['timestamp']);

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'from': from,
      'to': to,
      'data': data,
      'timestamp': timestamp
    };
  }
}
