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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            "My books", 
            style: Theme.of(context).textTheme.titleMedium
          ),
          SizedBox(
            height: 155,
            child: BookList()
          ),
          SizedBox(height: 10),
          Text(
            "Friends", 
            style: Theme.of(context).textTheme.titleMedium
          ),
          SizedBox(
            height: 155,
            child: BookList()
          ),
          SizedBox(height: 10),
          Text(
            "Trends", 
            style: Theme.of(context).textTheme.titleMedium
          ),
          SizedBox(
            height: 155,
            child: BookList()
          )
        ],
      )
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