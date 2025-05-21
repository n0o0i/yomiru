import 'package:flutter/material.dart';

class BookHorizonaLlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      scrollDirection: Axis.horizontal, 
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          child: SizedBox(
            width: 80,
            child: Card(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}