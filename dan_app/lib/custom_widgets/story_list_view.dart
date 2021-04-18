
import 'package:dan_app/data/story_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class StoryListView extends StatelessWidget {
  final List<StoryGroup> data;

  const StoryListView(this.data);

  SliverStickyHeader makeGroup(StoryGroup group) {
    return SliverStickyHeader.builder(
      builder: (context, state) => Container(
        height: 60.0,
        color: (state.isPinned ? Colors.pink : Colors.lightBlue)
            .withOpacity(1.0 - state.scrollPercentage),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          group.groupName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text(group.stories.elementAt(index).storyName),
            );
          },
          childCount: group.stories.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: data.map((group) => makeGroup(group)).toList()
      ,
    );
  }
}
