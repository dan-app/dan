import 'package:dan_app/data/mockup_data.dart';
import 'package:dan_app/pages/home_page.dart';
import 'package:dan_app/pages/stories_page.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Function onSettingsPressed;
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;

  const BasePage(
      {required this.onSettingsPressed,
      required this.pages,
      required this.items});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;

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
      body: widget.pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.items,
        currentIndex: _selectedIndex,
        onTap: (int index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
