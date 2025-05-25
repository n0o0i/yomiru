import 'package:flutter/material.dart';
import 'package:yomiru/frontend/Home/timeLine.dart';
import 'package:yomiru/frontend/Home/summary.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: const TabBar(
              tabs: <Widget>[
                Tab(text: 'Time Line'),
                Tab(text: 'Summary'),
              ]
            ),
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
