import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/icons/yomiru_icon.png',
            width: 48,
            height: 48,
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Time Line'),
              Tab(text: 'Summary'),
            ]
          )
        ),
        body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    TimeLineView(),
                    SummmaryView(),
                  ],
                )
              )
            ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'My books'),
            BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Friends'),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up_rounded), label: 'Trend'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}

class TimeLineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index){
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Colors.purple[100],
                    // child: Icon(Icon.person),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 10
                        ),
                      ),
                      Text(
                        '@userID xxxx/xx/xx',
                        style: TextStyle(
                          fontSize: 10
                        ),
                      ),
                    ]
                  ),
                  Spacer(),
                  SizedBox(
                    width: 100,
                    height: 200,
                    child: Card(
                      color: Colors.grey,
                    ),
                  ),
                ]
              ),
            ],
          ),
        );
      }
    );
  }
}

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