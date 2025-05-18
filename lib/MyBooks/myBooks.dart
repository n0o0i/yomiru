import 'package:flutter/material.dart';
import 'package:yomiru/shared/booksGridView.dart';

class Mybooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My books')),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: booksGridView(),
      )
    );
  }
}