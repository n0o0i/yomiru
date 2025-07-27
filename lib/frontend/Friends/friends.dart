import 'package:flutter/material.dart';
import 'package:yomiru/frontend/Friends/contentsListVIew.dart';
import 'package:yomiru/frontend/Friends/userListView.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: const TabBar(
              tabs: <Widget>[
                Tab(text: AppStrings.FriendsTabContentsList),
                Tab(text: AppStrings.FriendsTabUserList)
              ], 
            ),
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