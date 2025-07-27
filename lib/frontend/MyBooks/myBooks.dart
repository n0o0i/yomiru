import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/booksGridView.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class MyBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.MyBooksTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey
                      )  
                    ),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.deepPurple,
                    labelColor: Colors.deepPurple,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: [
                      Tab(text: AppStrings.MyBooksTabRead),
                      Tab(text: AppStrings.MyBooksTabToRead)
                    ]
                  )
                )
              ]
            )
          ),
          Expanded(
              child: TabBarView(
                children: [
                  booksGridView(),
                  booksGridView(),
                ]

              )
          )
        ]
      )
    ); 
  }
}