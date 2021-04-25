import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late List<dynamic> docs = <dynamic>[];

  void setDocs() async {
    var docs = await FirestoreController.getUserProgress(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      this.docs = docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    setDocs();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: docs
              .map(
                (dynamic e) => Text(
                  e.toString(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
