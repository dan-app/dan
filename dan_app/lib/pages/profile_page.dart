import 'package:dan_app/custom_widgets/achievements.dart';
import 'package:dan_app/custom_widgets/friends.dart';
import 'package:dan_app/custom_widgets/info.dart';
import 'package:dan_app/custom_widgets/statistics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  Function statisticsOpenedCallback;

  ProfilePage({required this.statisticsOpenedCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Info(
              onTap: () {},
              name: FirebaseAuth.instance.currentUser!.email!,
              avatar: '',
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  statisticsOpenedCallback(statisticsOpened: true);
                },
                child: Text("Статистика"),
              ),
            ),
            Statistics(),
            Friends(),

            Achievements(),
          ],
        ),
      ),
    );
  }
}
