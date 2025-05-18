import 'package:flutter/material.dart';
import 'package:yomiru/Home/TimeLine.dart';
import 'package:yomiru/Home/summary.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: <Widget>[
              Tab(text: 'Time Line'),
              Tab(text: 'Summary'),
            ]
          ),
          Expanded(
            child: TabBarView(
              children: [
                TimeLineView(),
                SummmaryView(),
              ],
            )
          )
        ],
      ) 
    );
  }
}
