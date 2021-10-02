class FirestoreMessage {
  FirestoreMessage(
      {required this.from,
      required this.to,
      required this.data,
      required this.timestamp});

  factory FirestoreMessage.fromMap(Map<String, dynamic> document) =>
      FirestoreMessage(
          from: document['from'],
          to: document['to'],
          data: document['data'],
          timestamp: document['timestamp']);

  final String? from;
  final String to;
  final String data;
  final String timestamp;

  Map<String, dynamic> toMap() {
    return {'from': from, 'to': to, 'data': data, 'timestamp': timestamp};
  }
}
