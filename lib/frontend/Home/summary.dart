import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookListSection.dart';

class SummmaryView extends StatelessWidget {
  final List<String> titles = ['My books', 'Friends', 'Trends'];

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