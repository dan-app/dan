class StoryGroup {
  final String groupName;

  List<Story> stories = <Story>[];

  StoryGroup({required this.groupName, required this.stories});
}

class Story {
  final String storyName;

  Story({required this.storyName});
}
