import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  final Achievement achievement;

  const AchievementItem({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          'https://www.shareicon.net/data/512x512/2016/12/19/863777_win_512x512.png',
          height: 100,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                achievement.name,
                textAlign: TextAlign.center,
                style: TextThemes.headline_6,
              ),
              Text(
                achievement.description,
                textAlign: TextAlign.center,
              ),
              /* SizedBox(
                height: 8,
                width: 200,
                child: LinearProgressIndicator(
                  value: achievement.current / achievement.max,
                ),
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}
