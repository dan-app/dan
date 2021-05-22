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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 5),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    story.image,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              story.storyName,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
