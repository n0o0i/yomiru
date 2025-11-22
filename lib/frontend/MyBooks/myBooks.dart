import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/booksGridView.dart';
import 'package:yomiru/frontend/shared/strings.dart';
import 'package:yomiru/frontend/MyBooks/addBookPage.dart';
import 'package:yomiru/frontend/MyBooks/bookSearchPage.dart';

class MyBooks extends StatelessWidget {
  const MyBooks({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookSearchPage())
              );
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            heroTag: "search",
            child: Icon(Icons.search),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBookPage())
              );
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            heroTag: "add",
            child: Icon(Icons.add),
          ),
        ],
      ),
    ); 
  }
}