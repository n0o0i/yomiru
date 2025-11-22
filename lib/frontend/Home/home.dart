import 'package:flutter/material.dart';
import 'package:yomiru/frontend/Home/timeLine.dart';
import 'package:yomiru/frontend/Home/summary.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
