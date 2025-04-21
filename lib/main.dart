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
            width: 24,
            height: 24,
          ),
        ),
        body: Column(
            children: [
              Container(
                height: 30,
                color: Colors.white, 
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Colors.yellow[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: 'Time Line'),
                    Tab(text: 'Summary'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    TimeLineListView(),
                    Center(child: Text('Summary Page')),
                  ],
                )
              )
            ],
        ),
      ),
    );
  }
}

class TimeLineListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index){
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple[100],
            // child: Icon(Icon.person),
          ),
          title: Text(
            'User Name',
            style: TextStyle(
              fontSize: 14
            ),
          ),
          subtitle: Text(
            '@userID xxxx/xx/xx',
            style: TextStyle(
              fontSize: 10
            ),
          ),
          trailing: Container(
            width: 50,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          contentPadding: EdgeInsets.all(8),
        );
      }
    );
  }
}