import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/models/firestoreUser.dart';
import 'package:mynewapp/services/database_service.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a FirebaseAuthUser object based on what firebaseAuth returns as a user
  FirebaseAuthUser? _userFromFirebaseAuth(User? user) {
    return user != null ? FirebaseAuthUser(uid: user.uid) : null;
  }

//   create a Stream to check if there's a user logged in (to use with a StreamBuilder widget)
  Stream<FirebaseAuthUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseAuth);
  }

// trying to use riverpod StreamProvider
  final firebaseUserProvider = StreamProvider.autoDispose((ref) {
    return FirebaseAuth.instance.authStateChanges();
  });

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
