import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookListSection.dart';

class Trend extends StatelessWidget {
  final List<String> titles = ['Top', 'nobel', 'Business', 'manga'];

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