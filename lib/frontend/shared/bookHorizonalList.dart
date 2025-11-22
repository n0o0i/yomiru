import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookDetails copy.dart';

class BookHorizonaLlist extends StatelessWidget {
  const BookHorizonaLlist({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      scrollDirection: Axis.horizontal, 
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShrinkingWidget())
              );
            },
            child: SizedBox(
              width: 80,
              height: 120,
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}