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

  static Future<void> addUser({
    required String email,
    required String password,
    required String username,
  }) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    users.doc(user.user!.uid).set(
      {
        'achievements': {
          'champion': 0,
          'diligent': 0,
          'experienced': 0,
          'friendly': 0,
          'neat': 0,
          'pretty': 0,
          'student': 0,
          'triumphant': 0,
        },
      },
    );

    users
        .doc(user.user!.uid)
        .update(<String, dynamic>{
          'email': user.user!.email,
          'username': username,
          'uid': user.user!.uid
        })
        .then((value) => print("User Added"))
        .catchError((Object error) => print("Failed to add user: $error"));
  }

  static Future<Map<String, dynamic>> getAchievements(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final user = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return (user.data() as Map<String, dynamic>)['achievements']
        as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getUsers() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    var map = <String, dynamic>{};
    await users.get().then(
      (value) {
        value.docs.forEach((doc) {
          map[doc.id] = doc.data();
        });
      },
    );
    print(map);
    return map;
  }

  static Future<Map<String, dynamic>> getUserData(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final user = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return user.data() as Map<String, dynamic>;
  }

  static Future<void> addFriend(String uid, String username) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    await users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('friends')
        .doc(username)
        .set(<String, dynamic>{'uid': uid});

  }
}
