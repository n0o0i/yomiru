import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookListSection.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class SummmaryView extends StatelessWidget {
  final List<String> titles = [AppStrings.homeSummaryMybooks, AppStrings.homeSummaryFriends, AppStrings.homeSummaryTrends];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: List.generate(3, (index) {
          return BookListSection(title: titles[index]);
        }), 
      ),
    );
  }
}