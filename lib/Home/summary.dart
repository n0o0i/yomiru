import 'package:flutter/material.dart';

class SummmaryView extends StatelessWidget {
  final List<String> titles = ['My books', 'Friends', 'Trends'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: List.generate(3, (index) {
          return BookListSection(title: titles[index]);
        }), 
      ),
    );
  }
}

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
                    "もっと見る >", 
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.18,
          child: BookList()
        ),
      ]
    );  
  }
}

class BookList extends StatelessWidget {
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