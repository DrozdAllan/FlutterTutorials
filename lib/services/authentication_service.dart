import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynewapp/services/database_service.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create a stream to check if there's a user logged in (to use with a StreamBuilder widget)
  Stream authState = FirebaseAuth.instance.authStateChanges();

  Future checkAuth() async {
    if (_auth.currentUser != null) {
      print('already connected');
      return _auth.currentUser;
    } else {
      print('not connected');
      return false;
    }
  }

  Future<void> register(String email, String username, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // if the createUserWithEmailAndPassword() return a non-null user, that means the registration is OK
      if (user == null) {
        throw Exception("No user found");
      } else {
        // if the registration is OK you can get the user uid to create a user doc in firestore
        await DatabaseService().saveNewUser(user.uid, username);
      }
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
