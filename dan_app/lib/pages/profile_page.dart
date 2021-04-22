import 'package:dan_app/data/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.name),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
