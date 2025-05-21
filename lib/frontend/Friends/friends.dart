import 'package:flutter/material.dart';
import 'package:yomiru/frontend/Friends/contentsListVIew.dart';
import 'package:yomiru/frontend/Friends/userListView.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Column(
        children: [
          const TabBar(
            tabs: <Widget>[
              Tab(text: 'Contents List'),
              Tab(text: 'Users List')
            ], 
          ),
          Expanded(
            child: TabBarView(
              children: [
                ContentsListView(),
                UserListView()
              ],
            ),
          )
        ],
      )
    );
  }
}