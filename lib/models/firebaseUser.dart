class FirebaseUser {
  final String email;
  final bool emailVerified;
  final bool isAnonymous;
  final String uid;

  FirebaseUser(this.email, this.emailVerified, this.isAnonymous, this.uid);
}
