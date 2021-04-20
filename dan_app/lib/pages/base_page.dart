import 'package:dan_app/pages/home_page.dart';
import 'package:dan_app/pages/stories_page.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Function onSettingsPressed;

  const BasePage({required this.onSettingsPressed});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;

  static final _pages = <Widget>[
    HomePage(),
    StoriesPage(),
    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dan'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => widget.onSettingsPressed(),
          ),
        ],
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Stories'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
