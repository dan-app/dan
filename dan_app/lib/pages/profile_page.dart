import 'dart:io';

import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/custom_widgets/achievement_item.dart';
import 'package:dan_app/custom_widgets/achievements.dart';
import 'package:dan_app/custom_widgets/friends.dart';
import 'package:dan_app/custom_widgets/info.dart';
import 'package:dan_app/custom_widgets/statistics.dart';
import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/utils/delegates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

//  final void Function({required bool statisticsOpened})statisticsOpenedCallback;

  const ProfilePage({
    //required this.statisticsOpenedCallback,
    required this.uid,
    required this.friend,
  });

  final bool friend;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final picker = ImagePicker();
  late File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!widget.friend)
                Info(
                  onTap: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.gallery);
                    setState(() async {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                        await FirestoreController.uploadAvatar(
                          _image,
                          widget.uid,
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: AchievementItem(achievement: Achievement(
                          name: 'Pretty',
                          description: 'Some description',
                          max: 100,
                          image:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
                          current: 50,
                        ),),),);
                      } else {
                        print('No image selected.');
                      }
                    });
                  },
                  name: FirebaseAuth.instance.currentUser!.email!,
                  uid: widget.uid,
                )
              else
                FutureBuilder<String>(
                  future: FirestoreController.getAvatarLink(widget.uid),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      radius: 59,
                      foregroundImage:
                          snapshot.connectionState == ConnectionState.none ||
                                  snapshot.data == null
                              ? null
                              : NetworkImage(snapshot.data!),
                    );
                  },
                ),
              /* Center(
                child: TextButton(
                  onPressed: () {
                    widget.statisticsOpenedCallback(statisticsOpened: true);
                  },
                  child: Text("Статистика"),
                ),
              ),*/
              Statistics(),
              Friends(
                uid: widget.uid,
              ),
              if (!widget.friend)
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
