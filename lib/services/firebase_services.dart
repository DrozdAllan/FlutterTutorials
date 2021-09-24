import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create a stream to check if there's a user logged in (to use with a StreamBuilder widget)
  Stream<User?> authState = FirebaseAuth.instance.authStateChanges();

  Future<bool> checkAuth() async {
    if (_auth.currentUser != null) {
      print('already connected');
      return true;
    } else {
      print('not connected');
      return false;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
