import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/custom_widgets/achievement_item.dart';
import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/data/mockup_data.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:dan_app/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Achievements extends StatefulWidget {
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  List<Achievement> data = <Achievement>[];

  var _itemCount = 3;

  @override
  void initState() {
    getAchievements();

    super.initState();
  }

  Future<void> getAchievements() async {
    final achievements = await FirestoreController.getAchievements(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      achievements.forEach(
        (String key, dynamic value) {
          data.add(
            Achievement(
              name: key.capitalize(),
              description: achievementDescriptions[key]!,
              level: value as int,
              image:
                  'https://www.shareicon.net/data/512x512/2016/12/19/863777_win_512x512.png',
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Achievements',
          style: TextThemes.headline_6,
        ),
        SizedBox(
          height: _itemCount * 125.0,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: _itemCount,
            itemBuilder: (context, index) => Card(
              color: (data.length > index)
                  ? data[index].level == 0
                      ? Colors.grey
                      : Colors.white
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (data.length > index)
                    ? AchievementItem(achievement: data[index])
                    : Container(),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(
              () {
                _itemCount = _itemCount == 3 ? 7 : 3;
              },
            );
          },
          child: Text(
            _itemCount == 3 ? 'Expand ▼' : 'Close ▲',
          ),
        ),
      ],
    );
  }
}
