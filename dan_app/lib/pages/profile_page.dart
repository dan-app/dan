import 'dart:io';

import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/custom_widgets/achievements.dart';
import 'package:dan_app/custom_widgets/friends.dart';
import 'package:dan_app/custom_widgets/info.dart';
import 'package:dan_app/custom_widgets/statistics.dart';
import 'package:dan_app/utils/delegates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  final void Function({required bool statisticsOpened})
      statisticsOpenedCallback;

  const ProfilePage({
    required this.statisticsOpenedCallback,
    required this.uid,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Info(
                onTap: () async {
                  final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                  setState(() {
                    if (pickedFile != null) {
                      _image = File(pickedFile.path);
                      FirestoreController.uploadAvatar(_image, widget.uid);
                    } else {
                      print('No image selected.');
                    }
                  });
                },
                name: FirebaseAuth.instance.currentUser!.email!,
                uid: widget.uid,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    widget.statisticsOpenedCallback(statisticsOpened: true);
                  },
                  child: Text("Статистика"),
                ),
              ),
              Statistics(),
              Friends(
                uid: widget.uid,
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await showSearch(
                    context: context,
                    delegate: FriendsSearchDelegate(),
                  );
                  if (result != MapEntry('', '')) {
                    FirestoreController.addFriend(result!.key, result.value);
                  }
                },
                child: Text('Add Friend'),
              ),
              Achievements(),
            ],
          ),
        ),
      ),
    );
  }
}
