class FirestoreUser {
  final String uid;
  final String name;
  final int? ducks;

  FirestoreUser({required this.uid, required this.name, this.ducks});

  factory FirestoreUser.fromMap(Map<String, dynamic> document) => FirestoreUser(
        uid: document['uid'] as String,
        name: document['name'] as String,
        ducks: document['ducks'] ?? 0,
      );

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'ducks': ducks};
  }
}
