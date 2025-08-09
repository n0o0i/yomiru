import 'package:flutter/material.dart';
import 'package:yomiru/frontend/Home/home.dart';
import 'package:yomiru/frontend/MyBooks/myBooks.dart';
import 'package:yomiru/frontend/Friends/friends.dart';
import 'package:yomiru/frontend/Trend/trend.dart';
import 'package:yomiru/frontend/Settings/settingsHome.dart';
import 'package:yomiru/frontend/shared/strings.dart';


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
    Trend(),
    SettingsHome(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: AppStrings.homePageNavBarHome
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: AppStrings.homePageNavBarMyBooks
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: AppStrings.homePageNavBarFriends
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: AppStrings.homePageNavBarTrend
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.homePageNavBarSettings
          ),
        ],
      ),
    );
  }
}

