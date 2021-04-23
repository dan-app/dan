import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      FirestoreController.getUserProgress(
                          FirebaseAuth.instance.currentUser!.uid);
                    },
                    child: Text(FirebaseAuth.instance.currentUser!.email!)),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
