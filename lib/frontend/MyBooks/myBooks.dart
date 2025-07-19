import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/booksGridView.dart';

class MyBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  'My books',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
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
                      Tab(text: 'read'),
                      Tab(text: 'to read')
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