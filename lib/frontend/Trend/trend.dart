import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookListSection.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class Trend extends StatelessWidget {
  final List<String> titles = [
    AppStrings.TrendsTop,
    AppStrings.TrendsNovel,
    AppStrings.TrendsBusiness,
    AppStrings.TrendsManga
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: List.generate(4, (index) {
          return BookListSection(title: titles[index]);
        }), 
      ),
    );
  }
}