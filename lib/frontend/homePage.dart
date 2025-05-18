import 'package:flutter/material.dart';
import 'package:yomiru/frontend/Home/home.dart';
import 'package:yomiru/frontend/MyBooks/myBooks.dart';
import 'package:yomiru/frontend/Friends/friends.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _selectedIndex = 0;

final List<Widget> _pages = [
  Home(),
  MyBooks(),
  Friends(),
  MyBooks(),
  MyBooks(),
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/icons/yomiru_icon.png',
          width: 48,
          height: 48,
        ),
      ),
      body:  _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'My books'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Friends'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: 'Trend'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
        ],
      ),
    );
  }
}

