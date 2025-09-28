import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookDetails copy.dart';

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
        return InkWell(
          onTap: () {
            Navigator.push(
              context, 
              // MaterialPageRoute(builder: (context) => Bookdetails())
              MaterialPageRoute(builder: (context) => ShrinkingWidget())
            );
          },
          child: Card(
            color: Colors.grey,            
          )
        );
      }
    );
  }
}