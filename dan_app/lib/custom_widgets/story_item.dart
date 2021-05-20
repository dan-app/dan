import 'package:dan_app/data/story_group.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  Story story;

  StoryItem({
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Image(
        image: AssetImage(
          story.image,
        ),
      ),
    );
  }
}
