import 'package:dan_app/data/achievement.dart';
import 'package:dan_app/data/dan_theme.dart';
import 'package:dan_app/data/story_group.dart';
import 'package:dan_app/utils/images.dart';
import 'package:flutter/material.dart';

const dummyThemes = [
  DanTheme(
      id: 'creation',
      name: 'Data creation & viewing',
      tasksCount: 3,
      icon: Icons.create),
  DanTheme(
      id: 'selection',
      name: 'Data selection',
      tasksCount: 4,
      icon: Icons.select_all),
  DanTheme(
      id: 'grouping',
      name: 'Operations & grouping',
      tasksCount: 6,
      icon: Icons.group),
  DanTheme(
      id: 'merging', name: 'Merging', tasksCount: 3, icon: Icons.merge_type),
  DanTheme(
      id: 'plotting',
      name: 'Plotting',
      tasksCount: 3,
      icon: Icons.scatter_plot),
];

List<StoryGroup> storyGroupMockup = <StoryGroup>[
  StoryGroup(groupName: 'First Chapter', stories: [
    Story(storyName: 'Titanic', image: CustomImages.titanic),
    Story(storyName: 'Illness', image: CustomImages.hospital),
  ]),
  StoryGroup(groupName: 'Second Chapter', stories: [
    Story(storyName: 'Agriculture', image: CustomImages.agriculture),
    Story(storyName: 'Students', image: CustomImages.students),
    Story(storyName: 'Math', image: CustomImages.dataScience),
  ]),
];
List<Achievement> achievementsMockup = <Achievement>[
  Achievement(
    name: 'Diligent',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
  Achievement(
    name: 'Experienced',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
  Achievement(
    name: 'Triumphant',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
  Achievement(
    name: 'Achievement',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
  Achievement(
    name: 'Achievement',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
  Achievement(
    name: 'Achievement',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
  Achievement(
    name: 'Achievement',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
  Achievement(
    name: 'Achievement',
    description: 'Some description',
    level: 0,
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMaYNRvusKgxDWx1JCxh8uRP1toy0BH0XKNWK0FAD9BIDdD1QSibxtYYyEX2du0VJyelo&usqp=CAU',
  ),
];
Map<String, String> achievementDescriptions = {
  'pretty': 'Upload an avatar',
  'diligent': ' Practice 3 days in a row',
  'experienced': 'Earn 100 experience points',
  'neat': 'Complete 10 tasks without mistakes',
  'storyteller': 'Read 1 story',
  'student': 'Read theory to the topic',
  'friendly': 'Add 3 friends',
};
