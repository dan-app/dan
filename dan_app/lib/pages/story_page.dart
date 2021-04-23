import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            //TODO сделать выполнение истории
          },
          child: Text("Done!"),
        ),
      ),
    );
  }
}
