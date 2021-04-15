class StoryGroupList {
  List<StoryGroup> groups = <StoryGroup>[];
}

class StoryGroup {
  final String groupName;

  List<Story> stories = <Story>[];

  StoryGroup(this.groupName);
}

class Story {
  final String storyName;

  Story(this.storyName);
}
