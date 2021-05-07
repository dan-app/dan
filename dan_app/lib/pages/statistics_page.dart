import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Map<String, int> docs = {};

  void setDocs() async {
    var docs = await FirestoreController.getUserProgress(
      FirebaseAuth.instance.currentUser!.uid,
    );
    if (mounted) {
      setState(() {
        this.docs = docs;
      });
    }
  }

  @override
  void initState() {
    setDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: ListView(
        children: docs.keys
            .map(
              (e) => Card(
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Row(
                    children: [
                      Text(e),
                      Spacer(),
                      Text(docs[e].toString()),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
