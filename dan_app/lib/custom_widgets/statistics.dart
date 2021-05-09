import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  var items = <StatisticsItem>[
    StatisticsItem(
      text: 'Очки опыта',
      icon: Icons.accessibility_new_outlined,
      mainText: 1000.toString(),
    ),
    StatisticsItem(
      text: 'Текущая лига',
      icon: Icons.account_balance,
      mainText: "Бронзовая",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
          mainAxisSpacing: 13,
        ),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(items[index].icon),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      items[index].mainText,
                      style: TextThemes.headline_6,
                    ),
                    Text(
                      items[index].text,
                      style: TextThemes.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatisticsItem {
  String text;
  String mainText;
  IconData icon;

  StatisticsItem({
    required this.text,
    required this.mainText,
    required this.icon,
  });
}
