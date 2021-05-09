import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreController {
  static Future<Map<String, int>> getUserProgress(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = await users.doc(uid).collection('themes').get();
    return Map.fromEntries(
      user.docs.map(
        (doc) => MapEntry(
          doc.id,
          doc.data()['tasks_done'] as int,
        ),
      ),
    );
  }

  static Future<void> addUser({required String email, required String password}) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    return users
        .doc(user.user!.uid)
        .set(<String, dynamic>{
          'name': user.user!.email, // John Doe
        })
        .then((value) => print("User Added"))
        .catchError((Object error) => print("Failed to add user: $error"));
  }
}
