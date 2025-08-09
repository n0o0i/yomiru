import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yomiru/frontend/Home/timeLine.dart';
import 'package:yomiru/frontend/Home/summary.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/icons/yomiru_icon.png',
          width: 48,
          height: 48,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: TabBar(
                tabs: [
                  Tab(text: AppStrings.homeTabTimeLine),
                  Tab(text: AppStrings.homeTabSummary),
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
      )
    );
  }
}
