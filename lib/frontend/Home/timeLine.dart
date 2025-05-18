import 'package:flutter/material.dart';

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