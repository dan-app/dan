import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  final Achievement achievement;
  AchievementItem({required this.achievement});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          achievement.image,
          height: 100,
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          children: [
            Text(
              achievement.name,
              style: TextThemes.headline_6,
            ),
            Text(achievement.description),
            SizedBox(
              height: 8,
              width: 200,
              child: LinearProgressIndicator(
                value: achievement.current / achievement.max,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
