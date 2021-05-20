import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Function settingsPressedCallback;

  const SettingsPage({required this.settingsPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () {
            settingsPressedCallback();
            FirebaseAuth.instance.signOut();
          },
          child: Text('Sign out'),
        ),
      ),
    );
  }
}
