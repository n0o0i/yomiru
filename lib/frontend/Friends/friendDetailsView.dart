import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/booksGridView.dart';

class FriendDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Name')),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: booksGridView(),
      )
    );
  }
}