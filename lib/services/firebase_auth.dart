import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutterbase/models/user.dart';
// import 'package:flutterbase/services/database_service.dart';

// import 'notification_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthenticationService {
//   Stream stream() {
//     _auth.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//   }

//   AppUser? _userFromFirebaseUser(User? user) {
//     initUser(user);
//     return user != null ? AppUser(user.uid) : null;
//   }

//   void initUser(User? user) async {
//     if (user == null) return;
//     NotificationService.getToken().then((value) {
//       DatabaseService(user.uid).saveToken(value);
//     });
//   }

//   Stream<AppUser?> get user {
//     return _auth.authStateChanges().map(_userFromFirebaseUser);
//   }

  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {
        // await DatabaseService(user.uid).saveUser(name, 0);

        // return _userFromFirebaseUser(user);
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

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      //   User? user = result.user;
      //   return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
