import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/booksGridView.dart';

class MyBooks extends StatelessWidget {
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