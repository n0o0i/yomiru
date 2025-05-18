import 'package:flutter/material.dart';

class booksGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 3
      ),
      itemCount: 50,
      itemBuilder: (context, Index) {
        return Card(
          color: Colors.grey,
        );
      }
    );
  }
}