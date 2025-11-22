import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookHorizonalList.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class BookListSection extends StatelessWidget {
  final String title;
  final bool isLast;

  const BookListSection({super.key, required this.title, this.isLast = false});

  @override
  Widget build(BuildContext context) {
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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title, 
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
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppStrings.bookListSectionListMore,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
          ],
        ),
        SizedBox(
          height: 120,
          child: BookHorizonaLlist()
        ),
        if (!isLast) SizedBox(height: 20), // 最後のセクション以外のみ余白を追加
      ]
    );  
  }
}