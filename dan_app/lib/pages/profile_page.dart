import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  Function statisticsOpenedCallback;

  ProfilePage({required this.statisticsOpenedCallback});

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
                      // TODO
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
          SizedBox(
            height: 100,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                statisticsOpenedCallback(statisticsOpened: true);
              },
              child: Text("Статистика"),
            ),
          ),
        ],
      ),
    );
  }
}
