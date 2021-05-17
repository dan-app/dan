import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/data/friend.dart';
import 'package:dan_app/pages/profile_page.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  final String uid;

  const Friends({required this.uid});

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  bool subscribtions_flag = true;

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
          child: subscribtions_flag
              ? FutureBuilder<List<String>>(
                  future: FirestoreController.getSubscriptions(widget.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none ||
                        snapshot.data == null) {
                      return Container();
                    }
                    return Column(
                      children: snapshot.data!
                          .map(
                            (uid) => FutureBuilder<String>(
                              future: FirestoreController.getUsernameById(uid),
                              builder: (context, childSnap) {
                                if (childSnap.connectionState ==
                                        ConnectionState.none ||
                                    childSnap.data == null) {
                                  return Container();
                                }
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute<ProfilePage>(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: Text(
                                            'Subscription',
                                          ),
                                        ),
                                        body: ProfilePage(
                                          friend: true,
                                          uid: uid,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(childSnap.data!),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                )
              : FutureBuilder<List<String>>(
                  future: FirestoreController.getSubscribers(widget.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none ||
                        snapshot.data == null) {
                      return Container();
                    }
                    return Column(
                      children: snapshot.data!
                          .map(
                            (uid) => FutureBuilder<String>(
                              future: FirestoreController.getUsernameById(uid),
                              builder: (context, childSnap) {
                                if (childSnap.connectionState ==
                                        ConnectionState.none ||
                                    childSnap.data == null) {
                                  return Container();
                                }
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute<ProfilePage>(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(title: Text('Subscriber'),),
                                        body: ProfilePage(
                                          friend: true,
                                          uid: uid,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(childSnap.data!),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
