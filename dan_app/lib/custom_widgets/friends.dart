import 'package:dan_app/data/friend.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  bool subscribtions_flag = true;
  List<Friend> subscriptions = <Friend>[
    Friend(uid: '0', name: 'Subscription'),
    Friend(uid: '0', name: 'Subscription'),
    Friend(uid: '0', name: 'Subscription'),
    Friend(uid: '0', name: 'Subscription'),

  ];
  List<Friend> subscribers = <Friend>[
    Friend(uid: '0', name: 'Subscriber'),
    Friend(uid: '0', name: 'Subscriber'),
    Friend(uid: '0', name: 'Subscriber'),
    Friend(uid: '0', name: 'Subscriber'),

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Friends',
          style: TextThemes.headline_5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChoiceChip(
                label: Text('Subscriptions'),
                selected: subscribtions_flag,
                onSelected: (selected) {
                  setState(() {
                    if (selected) subscribtions_flag = !subscribtions_flag;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChoiceChip(
                label: Text('Subscribers'),
                selected: !subscribtions_flag,
                onSelected: (selected) {
                  setState(() {
                    if (selected) subscribtions_flag = !subscribtions_flag;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: Column(
            children: subscribtions_flag
                ? subscriptions
                    .map(
                      (friend) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(),
                              SizedBox(
                                width: 8,
                              ),
                              Text(friend.name),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList()
                : subscribers
                    .map(
                      (friend) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(),
                              SizedBox(
                                width: 8,
                              ),
                              Text(friend.name),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
