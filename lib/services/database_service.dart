import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynewapp/models/firebaseUser.dart';
import 'package:mynewapp/services/authentication_service.dart';

class DatabaseService {
// the collection reference, firestore way of pointing to a noSQL directory
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveNewUser(String uid, String username) async {
    return await userCollection.doc(uid).set({'name': username});
  }

//   FirebaseUser _userFromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     var data = snapshot.data();
//     if (data == null) throw Exception("user not found");
//     return FirebaseUser(
//       uid: snapshot.id,
//       name: data['name'],
//       ducks: data['ducks'],
//     );
//   }

  Future<FirebaseUser> getUser() async {
    return await AuthenticationService().checkAuth();
    // print(user);
    // var data = FirebaseUser(
    //   uid: user.id,
    //   name: user['name'],
    //   ducks: user['waterCount'],
    // );
    // return data;
    // await userCollection.doc(uid).get();
  }
}
