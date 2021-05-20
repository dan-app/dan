class StoryGroup {
  final String groupName;

  List<Story> stories = <Story>[];

  StoryGroup({required this.groupName, required this.stories});
}

class Story {
  final String storyName;
  final String image;

  Story({
    required this.storyName,
    required this.image,
  });
}
