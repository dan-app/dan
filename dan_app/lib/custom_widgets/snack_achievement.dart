import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AchievementSnack extends StatelessWidget {
  final Achievement achievement;

  const AchievementSnack({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Image.network(
            achievement.image,
            height: 100,
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Achievement!',
                style: TextThemes.headline_6,
              ),
              Text(
                achievement.name,
                style: TextThemes.headline_6,
              ),
              Text(
                achievement.description,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
