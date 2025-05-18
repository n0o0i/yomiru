import 'package:flutter/material.dart';
import 'package:yomiru/Home/home.dart';
import 'package:yomiru/MyBooks/myBooks.dart';


void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _selectedIndex = 0;

final List<Widget> _pages = [
  Home(),
  Mybooks()
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/icons/yomiru_icon.png',
            width: 48,
            height: 48,
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _pages[_selectedIndex],
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
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
      ),
    );
  }
}

