import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/custom_widgets/achievement_item.dart';
import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/data/mockup_data.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:dan_app/utils/extensions.dart';
import 'package:flutter/material.dart';

class Achievements extends StatefulWidget {
  final String uid;
  const Achievements({required this.uid});
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  List<Achievement> data = <Achievement>[];

  var _itemCount = 3;

  @override
  void initState() {
    getAchievements(widget.uid);

    super.initState();
  }

  Future<void> getAchievements(String uid) async {
    final achievements = await FirestoreController.getAchievements(uid);
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
        Center(
          child: Text(
            'Achievements',
            style: TextThemes.headline_6,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: _itemCount * 125.0,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: _itemCount,
            itemBuilder: (context, index) => Card(
              color: (data.length > index)
                  ? data[index].level == 0
                      ? Colors.white54
                      : Colors.white
                  : Colors.white,
              child: Opacity(
                opacity: (data.length > index)
                    ? data[index].level == 0
                        ? 0.3
                        : 1
                    : 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (data.length > index)
                      ? AchievementItem(achievement: data[index])
                      : Container(),
                ),
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
