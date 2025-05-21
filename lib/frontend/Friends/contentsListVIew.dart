import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookHorizonalList.dart';

class ContentsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
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
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.17,
                child: ListView.builder(
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
                ),
              )
            ],
          ) 
        );
      },
    );
  }
}