import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookHorizonalList.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class BookListSection extends StatelessWidget {
  final String title;

  BookListSection({required this.title});

  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
    
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  height: screenHeight * 0.05,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "$title", 
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: screenHeight * 0.05,
                  alignment: Alignment.centerRight,
                  child: Text(
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    AppStrings.bookListSectionListMore , 
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.18,
          child: BookHorizonaLlist()
        ),
      ]
    );  
  }
}