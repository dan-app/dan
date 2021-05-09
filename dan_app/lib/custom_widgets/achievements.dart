import 'package:dan_app/data/achiement.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class Achievements extends StatelessWidget {
  List<Achievement> data = <Achievement>[
    Achievement(
      name: 'Achievement',
      description: 'Some description',
      max: 100,
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
      current: 50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Achievements',
          style: TextThemes.headline_6,
        ),
        // ignore: prefer-trailing-comma
        ...data
            .map(
              (achievement) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  ),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
