import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dan_app/utils/extensions.dart';

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
              description: 'Current level: $value',
              max: 100,
              image:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
              current: 50,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (data.length > index)
                    ? Row(
                        children: [
                          Image.network(
                            data[index].image,
                            height: 100,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            children: [
                              Text(
                                data[index].name,
                                style: TextThemes.headline_6,
                              ),
                              Text(data[index].description),
                              SizedBox(
                                height: 8,
                                width: 200,
                                child: LinearProgressIndicator(
                                  value: data[index].current / data[index].max,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(
              () {
                _itemCount = _itemCount == 3 ? 8 : 3;
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
