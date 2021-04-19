import 'package:dan_app/custom_widgets/story_list_view.dart';
import 'package:dan_app/data/mockup_data.dart';
import 'package:flutter/material.dart';

class StoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoryListView(MockupData.storyGroupMockup);
  }
}
