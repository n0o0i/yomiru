import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/booksGridView.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class MyBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppStrings.MyBooksTitle),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: TabBar(
                tabs: [
                  Tab(text: AppStrings.MyBooksTabRead),
                  Tab(text: AppStrings.MyBooksTabToRead)
                ]
              ),
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
      )
    ); 
  }
}